# frozen_string_literal: true

require 'csv'
require 'zip'
require 'archive/zip'

# rubocop:disable Metrics/ClassLength
class PondBatchCreator
  # rubocop:disable Metrics/AbcSize
  attr_reader :amount, :release_id, :unique_code, :ponds

  def initialize(release_id:, amount: 1, location: {}, unique_code: nil)
    @ponds = []
    @amount = amount.to_i
    @location = location
    @release_id = release_id
    @unique_code = unique_code.presence
    validate_generate_args(
      amount: @amount,
      release_id: @release_id,
      unique_pond_code: @unique_code.presence
    )
  end

  def create_ponds!
    return [] unless amount >= 1

    ActiveRecord::Base.transaction do
      amount.times do
        pond = Pond.create(
          key: pond_key,
          postal_code: location[:postal_code].presence,
          city: location[:city].presence,
          region: location[:region].presence,
          country: location[:country].presence,
          release_id: release_id
        )
        ponds << pond if pond.persisted?
      end

      errors << 'Pond creation error' if ponds.count != amount
      attach_files if success?
    end
    ponds
  end

  def location
    return {} unless @location.is_a?(ActionController::Parameters) || @location.is_a?(Hash)

    @location
  end

  def success?
    return false if ponds.count.zero?
    return false if amount.nil? || amount.zero?

    ponds.count == amount && errors.empty?
  end

  def errors
    @errors ||= []
  end

  def attach_files
    create_batch_record!
    create_csv_file!
    attach_csv_file
    create_zip_file!
    attach_zip_file
  end

  def create_batch_record!
    @batch_record ||= PondBatchRecord.create!(
      release_id: release_id,
      amount: amount
    )
  end

  def attach_csv_file
    @batch_record.csv_file.attach(
      io: File.open(@csv_tempfile.path),
      filename: "#{filename}.csv",
      content_type: 'text/csv'
    )
  end

  def create_csv_file!
    @csv_tempfile ||= Tempfile.new("#{filename}.csv")
    attributes = %w[Organization Key UUID URL Location Created]
    @csv_file ||= CSV.open(@csv_tempfile, 'w') do |csv|
      csv << attributes
      ponds.each do |pond|
        csv << [pond.organization.name, pond.key, pond.uuid, pond.url, pond.full_location,
                pond.created_at]
      end
    end
  end

  def attach_zip_file
    @batch_record.zip_file.attach(
      io: File.open(@zip_tempfile),
      filename: "#{filename}.zip",
      content_type: 'application/zip'
    )
  end

  def create_zip_file!
    @zip_tempfile = "tmp/#{filename}.zip"
    Zip::OutputStream.open(@zip_tempfile) { |zos| }

    Zip::File.open(@zip_tempfile, Zip::File::CREATE) do |zip|
      ponds.each do |pond|
        filename = pond.key.to_s
        image_file = Tempfile.new("tmp/#{filename}.png")

        File.open(image_file, 'wb', encoding: 'ASCII-8BIT') do |file|
          file.write(pond.create_qr_code)
        end

        zip.add("#{filename}.png", image_file.path)
      end
    end
  end

  private

  def pond_key
    unique_code.present? ? custom_hex_key(unique_code) : standard_hex_key
  end

  def filename
    org_name = Release.find(release_id).organization.name.downcase.chomp.gsub(' ', '_')
    date = Time.zone.now.strftime('%m%d%Y')
    time = Time.zone.now.strftime('%H%M')
    "#{org_name}_pond_creation_#{date}_#{time}"
  end

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

  # rubocop:disable Metrics/CyclomaticComplexity
  def validate_generate_args(amount:, release_id:, unique_pond_code: nil)
    if unique_pond_code.present? && unique_pond_code&.size.try(:>, 2)
      errors << 'Pond Code must be 2 characters'
    end

    errors << 'Release must be a String' unless release_id.is_a?(Integer)
    errors << 'Release not found!' if Release.find_by(id: release_id).blank?
    errors << 'Amount can not be lower than 0' unless amount >= 0
    errors << 'Amount must be lower than 1000' unless amount <= 1000
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/AbcSize
end
# rubocop:enable Metrics/ClassLength
