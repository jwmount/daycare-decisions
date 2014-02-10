json.array!(@people) do |person|
  json.extract! person, :id, :company_id, :first_name, :last_name, :title, :provider_id, :available, :available_on, :OK_to_contact, :active
  json.url person_url(person, format: :json)
end
