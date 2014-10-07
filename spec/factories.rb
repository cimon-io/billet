FactoryGirl.define do

  factory :company do
    name { |n| "Company #{n}" }
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation { password }

    company
  end

  factory :project do
    name { |n| "Project #{n}" }

    company
  end

end
