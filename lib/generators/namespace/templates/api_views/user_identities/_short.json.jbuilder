json.name resource.provider
json.url url_for([:provider, resource.provider.to_sym])

json.links do
  json.destroy api_url(resource, :delete)
end
