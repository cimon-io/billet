class CompanyUser < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user, inverse_of: :company_users
  belongs_to :company, inverse_of: :company_users

  scope :with_default_order, -> { order(created_at: :asc) }

end
