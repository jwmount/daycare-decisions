json.array!(@providers) do |provider|
  json.extract! provider, :id, :company_id, :name, :type_of_care, :NQS_rating, :languages, :url
  json.url provider_url(provider, format: :json)
end
