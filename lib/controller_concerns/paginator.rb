module Paginator
  extend ActiveSupport::Concern

  included do
    helper_method :next_page?
  end

  module ClassMethods

    def paginate!
      define_method(:end_of_association_chain) do
        association_chain_with_includes.page(params[:page] || 1).per(settings.per_page)
      end
    end

  end

  protected

  def next_page?
    collection.try(:next_page).present?
  end

end
