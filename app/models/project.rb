class Project < ApplicationRecord
  belongs_to :company, inverse_of: :projects

  validates :name, presence: true, uniqueness: true
end
