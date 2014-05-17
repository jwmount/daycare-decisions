class HomeController < ApplicationController
  
  def index

    @provider_ids = []    

    if params.include? :locality
    
      place = params[:locality].split(', ')
      locality = place[0]
      state = place[1]
      @addresses = Address.where( "locality = ?",locality).where("state = ?",state).select("addressable_id")
      unless @addresses.empty?
        @addresses.each { |a| @provider_ids << a.addressable_id }
      end #unless
    end #if

    @provider_ids
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
