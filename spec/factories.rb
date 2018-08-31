# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :company do
    name { Unique.next! { Faker::Company.name } }
  end

  factory :project do
    name { Unique.next! { Faker::Company.name } }
    company
  end

  factory :user do
  end

  factory :company_user do
    user
    company { Company.first || create(:company) }
  end

  factory :user_identity do
    email { Unique.next! { Faker::Internet.email } }
    uid { Unique.next! { Faker::Internet.slug } }
    provider "developer"
    user
  end
end
