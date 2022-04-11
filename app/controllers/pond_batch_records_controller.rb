class PondBatchRecordsController < ApplicationController
  before_action :set_pond_batch_record, only: [:show, :edit, :update, :destroy]

  # GET /pond_batch_records
  def index
    @pond_batch_records = PondBatchRecord.all
  end

  # GET /pond_batch_records/1
  def show
  end

  # GET /pond_batch_records/new
  def new
    @pond_batch_record = PondBatchRecord.new
  end

  # GET /pond_batch_records/1/edit
  def edit
  end

  # POST /pond_batch_records
  def create
    @pond_batch_record = PondBatchRecord.new(pond_batch_record_params)

    if @pond_batch_record.save
      redirect_to @pond_batch_record, notice: 'Pond batch record was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pond_batch_records/1
  def update
    if @pond_batch_record.update(pond_batch_record_params)
      redirect_to @pond_batch_record, notice: 'Pond batch record was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pond_batch_records/1
  def destroy
    @pond_batch_record.destroy
    redirect_to pond_batch_records_url, notice: 'Pond batch record was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pond_batch_record
      @pond_batch_record = PondBatchRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pond_batch_record_params
      params.require(:pond_batch_record).permit(:organization, :amount, :key)
    end
end
