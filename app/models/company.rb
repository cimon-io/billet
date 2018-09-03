class Company < ApplicationRecord
  has_many :company_users, -> { with_default_order }, inverse_of: :company
  has_many :projects, -> { with_default_order }, inverse_of: :company

  validates :name, presence: true, uniqueness: true
end
