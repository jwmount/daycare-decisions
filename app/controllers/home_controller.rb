class HomeController < ApplicationController
  
  def index

    if params.include? :locality_provider_ids
      @locality_provider_ids = []    
    #@post_code_provider_ids = []
    #@state_provider_ids = []
    #@addresses = []
    
      place = params[:locality].split(', ')
      locality = place[0]
      state = place[1]
      @addresses = Address.where( "locality = ? and state = ?", locality, state).select("addressable_id")
      if !@addresses.nil?
        @addresses.each do |a|
          @locality_provider_ids << a.addressable_id
        end
      end
    else
      @locality_provider_ids = []
    end
=begin    
    unless params[:locality].nil?
      @addresses = Address.where(  :locality => (params[:locality]).upcase ).select("addressable_id")
      if !@addresses.nil?
        @addresses.each do |a|
          @locality_provider_ids << a.addressable_id
        end
      end      
    end

    unless params[:post_code].nil?
      @addresses = Address.where( :post_code => params[:post_code]).select("addressable_id")
      if !@addresses.nil?
        @addresses.each do |a|
          @post_code_provider_ids << a.addressable_id
        end
      end      
    end

    if !params[:state].nil?
      @addresses = Address.where( :state => params[:state]).select("addressable_id")
      if !@addresses.nil?
        @addresses.each do |a|
          @state_provider_ids << a.addressable_id
        end
      end      
    end
=end
    
    respond_to do |format|
      format.html
      format.json { render json: [@providers] }
    end
  end 

  def edit
  end

  def show
    @provider = Provider.find params[:id]
    respond_to do |format|
      format.html
      format.json { render json: [@provider] }
    end

  end

  def update
  end

  def about
  end
  
  def advertise
  end

  def contact_us
  end

  def faq
  end

  def fact_sheets
  end

  def newsletter
  end

  def privacy_policy
  end

  def provider_services
  end

  def research
  end

  def terms_conditions
  end

end
