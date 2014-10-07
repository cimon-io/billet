# Used to apply a repository or aggregate root pattern
# in a denormalized fashion.
#
# This means that all of our entities
# regarldess of their generation compared to root
# will hold root's primary key and the belongs_to reader.
#
# Usage:
#
# class Company < ActiveRecord::Base
# end
#
# class User < ActiveRecord::Base
#   aggregate_root :company # will work just like belongs_to
# end
#
# class Project < ActiveRecord::Base
#   belongs_to :user
#   aggregate_root :company, through: :user
# end
#
# You can override all regular belongs_to options.
# There is an alias belongs_directly_to for those who may like it.
#
module AggregateRoot
  include Grabs

  def aggregate_root(root, options = {})
    through = options.delete(:through)
    foreign_key = options.fetch(:foreign_key, "#{root}_id")

    if through
      through_root = options.delete(:through_root) { root }
      as = options.delete(:as) { foreign_key }
      on = options.delete(:on) { :create }

      grabs foreign_key, from: through, as: as, on: on

      belongs_to root, get_through_options(through, through_root).merge(options)
      remove_method "#{root}=", "build_#{root}", "create_#{root}", "create_#{root}!"
    else
      belongs_to root, options
    end
  end
  alias_method :belongs_directly_to, :aggregate_root

  private def get_through_options(through, root)
    parent_class = reflect_on_association(foreign_key_source.to_sym).klass
    parent_class.reflect_on_association(root).options
  end

end
