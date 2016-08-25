json.name resource.name

json.links do
  json.show api_url(resource, :get)
  json.update api_url(:profile, :patch)
end
