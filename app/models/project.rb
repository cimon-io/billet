class Project < ActiveRecord::Base
  belongs_to :company

  validates :name, presence: true, uniqueness: true
end
