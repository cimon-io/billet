class Project < ActiveRecord::Base
  display_name :name
  belongs_to :company

  validates :name, presence: true, uniqueness: true

end
