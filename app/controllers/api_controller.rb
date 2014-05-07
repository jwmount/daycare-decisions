# localhost:3000/api => all providers
# localhost:3000/api/20 => provider :id = 20
# http://localhost:3000/api?utf8=%E2%9C%93&locality=burleigh%20wa&post_code=&state=&commit=Find+Address
# curl -i -H "Accept: application/json" http://localhost:3000/api/1  

class ApiController < ApplicationController
  include ActionController::MimeResponds

  def index
    @provider_ids = []
    @addresses = []

    # If no geo values are passed in params, get all the addresses and return
    # all providers.
    geo_req = params.except :utf8, :commit, :action, :controller
      
    if !geo_req.nil?
      @providers = Provider.all.order(:name)
    end

    if geo_req.include?(:locality) && !geo_req[:locality].empty?
      locality = geo_req[:locality].upcase
      @addresses = Address.where( "locality ~* ?", locality).select("addressable_id")

      if !@addresses.nil?
        @providers = Provider.where(:id => @addresses).order(:name).select("id, name")
      end      
    end

    if geo_req.include?(:post_code) && !geo_req[:post_code].empty?
      @addresses = Address.where( :post_code => params[:post_code]).select("addressable_id")
      if !@addresses.nil?
        @addresses.each do |a|
          @provider_ids << a.addressable_id
        end
        @providers = Provider.where(:id => @provider_ids).order(:name)#.limit(20)
      end      
    end

    if geo_req.include?(:state) && !geo_req[:state].empty?
      @addresses = Address.where( :state => params[:state]).select("addressable_id")
      if !@addresses.nil?
        @addresses.each do |a|
          @provider_ids << a.addressable_id
        end
        @providers = Provider.where(:id => @provider_ids).order(:name)#.limit(20)
      end      
    end
   
    unless @providers.nil?
      render json: [geo_req, @providers]
    else
      render json: [params]
    end

  end

  def show
  	@providers = Provider.find params[:id]
    render json: [params, @providers]
  end

  def latest
    latest = Provider.select("id, name, url, updated_at").order(:updated_at).limit(6)
  end

  def post_code_providers
    Provider.where(:id => @post_code_provider_ids).where(@rqry).order(:name)
  end
end
