class User < ActiveRecord::Base
  has_paper_trail

  has_many :user_identities, -> { with_default_order }
  has_many :company_users, -> { with_default_order }, inverse_of: :user
  has_many :companies, -> { with_default_order }, through: :company_users

  scope :with_default_order, -> { order(priority: :asc) }

  before_create :generate_remember_token

  def config
    Settings.default_user_config
  end

  protected

  def generate_remember_token
    self.remember_token = SecureRandom.hex(20).encode('UTF-8')
  end

end
