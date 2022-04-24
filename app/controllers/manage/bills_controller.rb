# frozen_string_literal: true

module Manage
  class BillsController < ApplicationController
    before_action :set_bill, only: %i[show edit update destroy]
    before_action :set_bill_enums, only: %i[new edit create]
    before_action :converted_params, only: %i[create update]

    def index
      @bills = Bill.all
    end

    def show; end

    def new
      @bill = Bill.new
    end

    def edit; end

    def create
      @bill = Bill.new(bill_params.merge(converted_params))
      if @bill.save
        redirect_to manage_bill_url(@bill), notice: 'Bill was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @bill.update(bill_params.merge(converted_params))
        redirect_to manage_bill_url(@bill), notice: 'Bill was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @bill.destroy
      redirect_to manage_bills_url, notice: 'Bill was successfully destroyed.'
    end

    private

    def set_bill
      @bill = Bill.friendly.find(params[:id])
    end

    def set_bill_enums
      @recurrence = { 'Annual': 0, 'Monthly': 1 }
      @expense_type = { 'Fixed': 0, 'Variable': 1 }
    end

    def converted_params
      paid = bill_params['paid'] == '1'
      recurrence = bill_params['recurrence'].to_i
      expense_type = bill_params['expense_type'].to_i
      { recurrence: recurrence, expense_type: expense_type, paid: paid }
    end

    def bill_params
      params.require(:bill).permit(:name, :description, :amount, :paid, :due_at, :recurrence,
                                   :expense_type, :document)
    end
  end
end
