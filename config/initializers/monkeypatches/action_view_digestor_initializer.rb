# frozen_string_literal: true

module ActionView
  class Digestor
    class << self
      # https://github.com/rails/rails/blob/v5.2.0/actionview/lib/action_view/digestor.rb#L46-L72
      # rubocop:disable Metrics/AbcSize, Style/IdenticalConditionalBranches, Lint/AssignmentInCondition
      def tree(name, finder, partial = false, seen = {})
        logical_name = name.gsub(%r{/_}, "/")

        # Start patching
        finder.formats = [finder.rendered_format] if finder.rendered_format
        finder.formats.push(:html) if %i[json js].include?(finder.rendered_format)
        # End patching

        if template = finder.disable_cache { finder.find_all(logical_name, [], partial, []).first }
          finder.rendered_format ||= template.formats.first

          if node = seen[template.identifier] # handle cycles in the tree
            node
          else
            node = seen[template.identifier] = Node.create(name, logical_name, template, partial)

            deps = DependencyTracker.find_dependencies(name, template, finder.view_paths)
            deps.uniq { |n| n.gsub(%r{/_}, "/") }.each do |dep_file|
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
      # rubocop:enable Metrics/AbcSize, Style/IdenticalConditionalBranches, Lint/AssignmentInCondition
    end
  end
end

Rails.logger.warn "Version of 'rails' gem has been changed! Review Monkey Patch #{__FILE__}. Subject: Fix digesting templates with mixed formats (https://github.com/rails/rails/issues/28503)" if Rails.version != "5.2.0"
Rails.logger.warn "Seems a Monkey Patch in #{__FILE__} is too old. Check fresh version of 'rails' gem. Subject: Fix digesting templates with mixed formats (https://github.com/rails/rails/issues/28503)" if Time.now.utc > Time.utc(2018, 1, 24)
