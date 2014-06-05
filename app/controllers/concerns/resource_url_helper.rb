module ResourceUrlHelper
  extend ActiveSupport::Concern

  included do
    hide_action :polymorphic_url
    helper_method :polymorphic_url
  end

  RESOURCES = {
    User => ->(resource) { [resource.company, resource] },
    # SubAccount => ->(resource) { [resource.account, resource] },
    # Backlink => ->(resource) { [resource.article.network, resource.article, resource] },
    # Page => ->(resource) { [resource.campaign, resource] },
  }
  RESOURCES.default = ->(resource) { resource }

  def polymorphic_url(record_or_hash_or_array, options={})
    super(RESOURCES[record_or_hash_or_array.class][record_or_hash_or_array], options)
  end

end
