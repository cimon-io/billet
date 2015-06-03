class Project < ActiveRecord::Base
  has_paper_trail
  belongs_to :company

  validates :name, presence: true, uniqueness: true
end
