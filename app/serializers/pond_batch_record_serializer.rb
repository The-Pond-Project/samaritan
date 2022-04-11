class PondBatchRecordSerializer < ActiveModel::Serializer
  attributes :id, :organization, :amount, :key
end
