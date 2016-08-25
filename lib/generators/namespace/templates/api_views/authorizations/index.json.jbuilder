json.array! OmniAuth::Builder.providers do |provider|
  json.name provider
  json.url url_for([:provider, provider])
end
