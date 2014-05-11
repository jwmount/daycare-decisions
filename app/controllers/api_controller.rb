# localhost:3000/api => all providers
# localhost:3000/api/locations/bri => locations with 'b-r-i' prefix
# http://localhost:3000/api?utf8=%E2%9C%93&locality=burleigh%20wa&post_code=&state=&commit=Find+Address
# curl -i -H "Accept: application/json" http://localhost:3000/api/locations/Bro
# curl -i -H "Accept: application/json" http://daycare-decisions.herokuapp.com/api/locations/Bri  
class ApiController < ApplicationController
  include ActionController::MimeResponds
  after_filter :set_access_control_headers

  #
  # Get all locations in soundex queries, e.g. 'B' followed by 'Bri'
  #
  def locations
    if params.include?(:locality) && !params[:locality].empty?
      city_states = []
      locality = params[:locality]
      @addresses = Address.where( "locality ~* ?", locality).select("locality, state").distinct
      @addresses.each do |aid| 
        city_states << "#{aid.locality.split.map(&:capitalize).*(' ')}, #{aid.state}"
      end
      render json: city_states
    end
  end #locations

  # Return all providers, or if filters are present, filtered ones.
  # <host>/api/providers
  # <host>/api/providers/?locality=Brisbane%2c%20&real_grass=1
  def providers
    filter = params.except :utf8, :commit, :action, :controller
    if filter.empty?
      render :json => Provider.all.order(:name)
    else
      geo_ids, services = get_queries filter
      providers = Provider.where(:id => geo_ids).where(services).order("name")      
      render :json => [providers, params, geo_ids, services]
    end
  end


  # Construct where clauses
  def get_queries filter
    elements = filter[:locality].split(',')
    city = elements[0]
    state = elements[1].lstrip
    geo_ids = Address.where("locality ~* ? and state = ?", city, state ).select("addressable_id")
    # get the services filter set, first remove the location elements
    services = filter.except :locality, :post_code, :state
    return geo_ids, services
  end


  def provider
    render :json => Provider.where( "id = ?", params[:id])
  end

  # from http://madhukaudantha.blogspot.com/2011/05/access-control-allow-origin-in-rails.html
  # called by before filter
  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = 'http://localhost:8081/' 
    headers['Access-Control-Request-Method'] = '*' 
  end

  # remove this if catch-all route that calls it is removed.
  def xss_options_request
    render :text => ""
  end
end
