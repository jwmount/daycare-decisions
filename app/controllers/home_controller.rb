class HomeController < ApplicationController
  
  def index

    @locality_provider_ids = []    
    @post_code_provider_ids = []
    @state_provider_ids = []
    @addresses = []

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

    
    respond_to do |format|
      format.html
      format.json { render json: [@providers] }
    end
  end 

  def edit
  end

  def show
    @provider = Provider.find params[:id]
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
