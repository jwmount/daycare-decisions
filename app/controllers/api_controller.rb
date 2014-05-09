# localhost:3000/api => all providers
# localhost:3000/api/20 => provider :id = 20
# http://localhost:3000/api?utf8=%E2%9C%93&locality=burleigh%20wa&post_code=&state=&commit=Find+Address
# curl -i -H "Accept: application/json" http://localhost:3000/api/1  

class ApiController < ApplicationController
  include ActionController::MimeResponds

  def locations
    if params.include?(:locality) && !params[:locality].empty?
      city_states = []
      locality = params[:locality]
      @addresses = Address.where( "locality ~* ?", locality).select("locality, state")
      @addresses.each do |aid| 
        city_states << "#{aid.locality.split.map(&:capitalize).*(' ')}, #{aid.state}"
      end
      render json: city_states
    end
  end #locations

  # Return all providers, or if filters are present, filtered ones.
  def providers
    filter = params.except :utf8, :commit, :action, :controller
    if filter.empty?
      render :json => Provider.all.order(:name)
    else
      geo_ids, services = get_queries filter
      providers = Provider.where(:id => geo_ids).where(services).order("name")      
      render :json => providers
    end
  end

  # Get providers under filters 
  def get_queries filter
    elements = filter[:locality].gsub(/,/,'').split
    city = elements[0]
    state = elements[1]
    geo_ids = Address.where("locality ~* ? and state = ?", city, state ).select("addressable_id")

    # get the services filter set, first remove the location elements
    services = filter.except :locality, :post_code, :state
    return geo_ids, services
  end


  def provider
    render :json => Provider.where( "id = ?", params[:id])
  end



end
