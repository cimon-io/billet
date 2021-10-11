# frozen_string_literal: true

# supported_version: Rails::VERSION::STRING '~> 7.0.0.alpha2'

# https://github.com/rails/rails/issues/28503
module ActionView
  class Digestor
    class << self
      # https://github.com/rails/rails/blob/v7.0.0.alpha2/actionview/lib/action_view/digestor.rb#L43-L68
      # rubocop:disable Style/IdenticalConditionalBranches, Lint/AssignmentInCondition, Style/PercentLiteralDelimiters
      def tree(name, finder, partial = false, seen = {})
        logical_name = name.gsub(%r|/_|, "/")
        interpolated = name.include?("#")

        path = TemplatePath.parse(name)

        # Start patching
        finder.formats = [finder.rendered_format] if finder.rendered_format
        finder.formats.push(:html) if %i[json js].include?(finder.rendered_format)
        # End patching

        if !interpolated && (template = find_template(finder, path.name, [path.prefix], partial, []))
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
          unless interpolated # Dynamic template partial names can never be tracked
            logger.error "  Couldn't find template for digesting: #{name}"
          end

          seen[name] ||= Missing.new(name, logical_name, nil)
        end
      end
      # rubocop:enable Style/IdenticalConditionalBranches, Lint/AssignmentInCondition, Style/PercentLiteralDelimiters
    end
  end
end
