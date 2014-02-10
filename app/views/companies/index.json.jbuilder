json.array!(@companies) do |company|
  json.extract! company, :id, :name, :active, :url, :description
  json.url company_url(company, format: :json)
end
