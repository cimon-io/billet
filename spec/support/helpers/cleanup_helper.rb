# frozen_string_literal: true

module CleanupHelper
  # Remove entities creation from `before(:all)` blocks to avoid truncation problem, which is reason to random failed tests. Instead of this use our own `fixture` helper which creates record `before(:all)` then remove it `after(:all)`.
  #
  # Instead of this:
  #
  #   before(:all) do
  #     @company = create :company
  #     @project = create :project
  #   end
  #
  # Use the following:
  #
  #   fixture(:company) { create :company }
  #   fixture(:project) { create :project }
  #
  def fixture(name, &block)
    before(:all) { instance_variable_set("@#{name}", instance_eval(&block)) }
    let(name.to_sym) { instance_variable_get("@#{name}") }
    after(:all) { instance_variable_get("@#{name}").class.where(id: instance_variable_get("@#{name}").id).delete_all if instance_variable_get("@#{name}") }
  end

  # To remove records in after all with single line
  # Instead of:
  #
  #   after(:all) do
  #     @company.really_delete
  #     @project1.really_delete
  #     @project2.really_delete
  #   end
  #
  # Example of usage:
  #
  #   cleanup :company, :project1, :project2
  #
  # Don't need to call cleanup if record has been creagted via `fixture` method
  #
  def cleanup(*all_record_names)
    after(:all) do
      all_record_names.map { |n| instance_variable_get("@#{n}") }.group_by(&:class).each do |klass, records|
        klass.where(id: records.compact.map(&:id)).delete_all
      end
    end
  end
end
