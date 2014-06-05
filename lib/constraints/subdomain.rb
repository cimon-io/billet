module Constraints

  class Subdomain

    RESERVED = %w(www ftp mail pop smtp ssl sftp imap owner api)

    def self.none
      SubdomainNone.new
    end

    def self.present
      SubdomainPresent.new
    end

    def self.matches(constraint)
      SubdomainMatches.new(constraint)
    end

    def signup
      request.subdomain == 'signup'
    end

    def admin
      request.subdomain == 'admin'
    end

    def api
      ['api', 'sl'].includes?(request.subdomain)
    end

    def self.method_missing(name, *args)
      matches(name.to_s.dasherize)
    end

  end

  class SubdomainNone < Subdomain
    def matches?(request)
      request.subdomain.blank?
    end
  end

  class SubdomainPresent < Subdomain
    def matches?(request)
      request.subdomain.present?
    end
  end

  class SubdomainMatches < Subdomain
    def initialize(constraint)
      @constraint = constraint
    end

    def matches?(request)
      request.subdomain.present? && case @constraint
        when Hash
          only?(request.subdomain) && except?(request.subdomain)
        else
          @constraint === request.subdomain
      end
    end

    private

    def only?(str)
      return true unless @constraint.key?(:only) && @constraint.key?(:only).present?
      Array(@constraint[:only]).any? { |c| c === str }
    end

    def except?(str)
      return true unless @constraint.key?(:except) && @constraint.key?(:except).present?
      !Array(@constraint[:except]).any? { |c| c === str }
    end
  end

end

