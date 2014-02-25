json.array!(@waitlist_applications) do |waitlist_application|
  json.extract! waitlist_application, :id, :guardian_id
  json.url waitlist_application_url(waitlist_application, format: :json)
end
