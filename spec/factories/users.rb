# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'noname@noname.com' }
    password { 'someRandomPass' }
  end
end
