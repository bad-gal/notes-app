# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    subject { 'Draft Information' }
    text { 'This is just a test to make sure that everything works as expected.' }
    user { nil }
  end
end
