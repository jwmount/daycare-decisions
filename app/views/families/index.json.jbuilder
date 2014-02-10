json.array!(@families) do |family|
  json.extract! family, :id, :surname
  json.url family_url(family, format: :json)
end
