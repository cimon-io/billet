FactoryGirl.define do

  factory :company do
    sequence(:name) { |n| "Company #{n}" }
  end

  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    company
  end

  factory :user do
  end

  factory :company_user do
    user
    company { Company.first || create(:company) }
  end

  factory :user_identity do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:uid) { email }
    provider "developer"
    user
  end

end
