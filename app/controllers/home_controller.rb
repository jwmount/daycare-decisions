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


    # @providers = Provider.where(:id => provider_ids).order(:name)
    # @providers = Provider.where(:id => provider_ids).select("id, name, url, updated_at").order(:name)
 

     # Refined queries, based on services offered by providers
    rqry = {}
    @rqry = {}
     
     if params[:air_conditioning] and !params[:air_conditioning].empty?
       @rqry[:air_conditioning] = true
     end
     
     if params[:bus_service] and !params[:bus_service].empty?
       @rqry[:bus_service] = true
     end
     
     if params[:disposable_nappies] and !params[:disposable_nappies].empty?
       @rqry[:disposable_nappies] = true
     end
     
     if params[:cloth_nappies] and !params[:cloth_nappies].empty?
       @rqry[:cloth_nappies] = true
     end
     
     if params[:excursions] and !params[:excursions].empty?
       @rqry[:excursions] = true
     end
     
     if params[:extended_hours_for_kindys] and !params[:extended_hours_for_kindys].empty?
       @rqry[:extended_hours_for_kindys] = true
     end
     
     if params[:food_provided] and !params[:food_provided].empty?
       @rqry[:food_provided] = true
     end
     
     if params[:guest_speakers] and !params[:guest_speakers].empty?
       @rqry.merge[:guest_speakers] = true
     end
     
     if params[:languages] and !params[:languages].empty?
       @rqry[:languages] = true
     end
     
     if params[:real_grass] and !params[:real_grass].empty?
       @rqry[:real_grass] = true
     end
     
     if params[:secure_access] and !params[:secure_access].empty?
       @rqry[:secure_access] = true
     end
     
     if params[:siblings_given_priority] and !params[:siblings_given_priority].empty?
       @rqry[:siblings_given_priority] = true
     end
     
     if params[:technology] and !params[:technology].empty?
       @rqry[:technology] = true
     end
     
     if params[:vaccinations_compulsory] and !params[:vaccinations_compulsory].empty?
       @rqry[:vaccinations_compulsory] = true
     end
     
     if params[:waitlist_online] and !params[:waitlist_online].empty?
       @rqry[:waitlist_online] = true
     end
     
     if params[:waitlist_reimbursed] and !params[:waitlist_reimbursed].empty?
       @rqry[:waitlist_reimbursed] = true
     end
     
    
    respond_to do |format|
      format.html
      format.json { render json: [@providers] }
    end
  end 

  def edit
  	debugger
  end

  def show
    @provider = Provider.find params[:id]
  end

  def update
  	debugger
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
