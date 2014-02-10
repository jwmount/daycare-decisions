json.array!(@agencies) do |agency|
  json.extract! agency, :id, :name, :description, :governing_body, :jurisdiction
  json.url agency_url(agency, format: :json)
end
