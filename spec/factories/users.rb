# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'lebronjames@lakers.com' }
    password { 'imbron' }
  end
end
