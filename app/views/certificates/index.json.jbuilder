json.array!(@certificates) do |certificate|
  json.extract! certificate, :id, :name, :active, :description, :for_person, :for_company, :for_provider
  json.url certificate_url(certificate, format: :json)
end
