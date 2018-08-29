class UserApplication < ActiveRecord::Base
  belongs_to :user

  scope :with_default_order, -> { order(:created_at) }

  has_secure_token :token
end
