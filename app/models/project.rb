class Project < ApplicationRecord
  has_paper_trail

  belongs_to :company, inverse_of: :projects

  validates :name, presence: true, uniqueness: true
end
