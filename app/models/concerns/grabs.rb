# Use this to denormalize a field in activerecord
# or to cache an attribute.
#
# Usage:
#
#     class User < ActiveRecord::Base
#       belongs_to :company
#     end
#
#     class Project < ActiveRecord::Base
#       extend Grabs
#       belongs_to :user
#
#       grabs :company_id, from: :user
#       # This line is essentially equivalent to
#       before_validation do
#         self.company_id = user.company_id
#       end
#     end
#
# What you can do:
#
#     grabs :company_id, from: :user
#     grabs :name, from: user, as: :author_name
#     grabs :something, from: :somewhere, on: :create
#
module Grabs
  def grabs(field, options = {})
    from = options.delete(:from) { raise "You must provide ':from' option" }
    target = options.delete(:as) { field }

    before_validation options do
      source = self.send(from)
      self.send("#{target}=", source.send(field)) if source
    end
  end
end
