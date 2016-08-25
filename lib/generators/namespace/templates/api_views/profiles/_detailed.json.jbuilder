json.uid resource.id
json.companies resource.companies, partial: partial_name(Company, 'short'), as: :resource

json.links do
  json.update api_url(:profile, :patch)
end
