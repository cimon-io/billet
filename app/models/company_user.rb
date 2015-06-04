class CompanyUser < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :company

  scope :with_default_order, -> { order(created_at: :asc) }

end
