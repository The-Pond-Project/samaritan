class PondBatchCreator
  attr_reader :amount, :release_id, :unique_code, :ponds

  def initialize(amount: 1, location: {}, release_id:, unique_code: nil)
    @ponds = []
    @amount = amount.to_i
    @location = location
    @release_id = release_id
    @unique_code = unique_code.presence
    validate_generate_args(
      amount: @amount, 
      release_id: @release_id, 
      location: @location, 
      unique_pond_code: @unique_code.presence
    )
  end

  def create_ponds
    ActiveRecord::Base.transaction do 
      amount.times do
          pond = Pond.create(
            key: unique_code.present? ? custom_hex_key(unique_code) : standard_hex_key,
            postal_code: location[:postal_code].presence,
            city: location[:city].presence,
            region: location[:region].presence,
            country: location[:country].presence,
            release_id: release_id
          )
          ponds << pond if pond.persisted?
      end
    end
    errors << 'Pond creation error' if ponds.count != amount
    create_batch_record! if success?
    ponds
  end

  def location
    return {} unless @location.is_a?(Hash)
    @location
  end

  def success?
    return false if ponds.count == 0
    return false if amount.nil? || amount == 0
    ponds.count == amount && errors.empty?
  end

  def errors
    @errors ||= []
  end

  def create_batch_record!
    PondBathRecord.create!(
      release_id: release_id,
      amount: amount
    )
  end

  def csv
    attributes = ['organization', 'key', 'uuid', 'location', 'created_at']
    @csv ||= ::CSV.generate( headers: true) do |csv|
                      csv << attributes
                      ponds.each do |pond|
                        csv << [pond.organization.name, pond.key, pond.uuid, pond.full_location, pond.created_at]
                      end
                    end
  end

  private 

  # standard pond key hex
  # Example: P-40326A
  def standard_hex_key
    "P-#{SecureRandom.hex(3).upcase}"
  end

  # custom pond key hex
  # Example if unique code was 'GN': P-GN326A
  def custom_hex_key(unique_code)
    "P-#{unique_code}".upcase + SecureRandom.hex(2).upcase
  end

  def validate_generate_args(amount:, location:, release_id:, unique_pond_code: nil)
    if unique_pond_code.present? && unique_pond_code&.size > 2
      errors << 'Pond Code must be 2 characters'
    end

    errors << 'Release must be a String' unless release_id.is_a?(Integer)
    errors << 'Amount can not be lower than 0' unless amount >= 0
    errors << 'Amount must be lower than 1000' unless amount <= 1000
  end
end