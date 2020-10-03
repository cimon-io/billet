# frozen_string_literal: true

# supported_version: Rails::VERSION::STRING '~> 6.0.3'

# https://github.com/rails/rails/issues/28503
module ActionView
  class Digestor
    class << self
      # https://github.com/rails/rails/blob/v6.0.3.2/actionview/lib/action_view/digestor.rb#L42-L64
      # rubocop:disable Style/IdenticalConditionalBranches, Lint/AssignmentInCondition, Style/PercentLiteralDelimiters
      def tree(name, finder, partial = false, seen = {})
        logical_name = name.gsub(%r|/_|, "/")

        # Start patching
        finder.formats = [finder.rendered_format] if finder.rendered_format
        finder.formats.push(:html) if %i[json js].include?(finder.rendered_format)
        # End patching

        if template = find_template(finder, logical_name, [], partial, [])
          if node = seen[template.identifier] # handle cycles in the tree
            node
          else
            node = seen[template.identifier] = Node.create(name, logical_name, template, partial)

            deps = DependencyTracker.find_dependencies(name, template, finder.view_paths)
            deps.uniq { |n| n.gsub(%r|/_|, "/") }.each do |dep_file|
              node.children << tree(dep_file, finder, true, seen)
            end
            node
          end
        else
          unless name.include?("#") # Dynamic template partial names can never be tracked
            logger.error "  Couldn't find template for digesting: #{name}"
          end

          seen[name] ||= Missing.new(name, logical_name, nil)
        end
      end
      # rubocop:enable Style/IdenticalConditionalBranches, Lint/AssignmentInCondition, Style/PercentLiteralDelimiters
    end
  end
end
