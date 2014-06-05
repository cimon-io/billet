class Project < ActiveRecord::Base
  belongs_to :company

  validates :name, presence: true, uniqueness: true

  def display_name
    return self.name if self.name
    return "Project #{self.id}" if self.id
    return "New project"
  end

end
