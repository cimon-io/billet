class User < ActiveRecord::Base
  has_paper_trail

  has_many :user_identities, -> { with_default_order }
  has_many :company_users, -> { with_default_order }
  has_many :companies, -> { with_default_order }, through: :company_users

  scope :with_default_order, -> { order(priority: :asc) }

  def config
    Settings.default_user_config
  end

end
