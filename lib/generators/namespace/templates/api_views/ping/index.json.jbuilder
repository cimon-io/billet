json.answer "pong"

if signed_in?
  json.secured "pong"

  json.links do
    json.profile api_url(:profile, :get)
    json.companies api_url(:companies, :get)
    json.projects api_url(:projects, :get)
  end
else
  json.links do
    json.authrizations api_url(:authorizations, :get)
  end
end
