json.data collection, partial: partial_name(resource_class, 'short'), as: :resource

json.links({})
json.links do
  json.next api_url(url_for([resource_class, page: collection.next_page, only_path: false]), :get) if next_page?
end
