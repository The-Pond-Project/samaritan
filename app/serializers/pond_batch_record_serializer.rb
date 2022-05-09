# frozen_string_literal: true

class PondBatchRecordSerializer < ActiveModel::Serializer
  attributes :id, :organization, :amount, :key
end
