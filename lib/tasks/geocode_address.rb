module geocode_address


  GEOCODE_BASE_URL = 'http://maps.googleapis.com/maps/api/geocode/json'

  def geocode(address,sensor)
    geo_args = {
        'address': address,
        'sensor': false,
        'key': ENV['google_api_key']  
    }

  
  end
end