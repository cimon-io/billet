class Company < ActiveRecord::Base
  has_many :users
  has_many :projects

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :users

end
