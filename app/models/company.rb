class Company < ActiveRecord::Base

  has_many :users
  has_many :projects

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :users

  def display_name
    return self.name if self.name
    return "Company #{self.id}" if self.id
    return "New company"
  end

end
