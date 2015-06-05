class Company < ActiveRecord::Base
  has_paper_trail
  has_many :company_users, -> { with_default_order }
  has_many :projects, -> { with_default_order }

  validates :name, presence: true, uniqueness: true
end
