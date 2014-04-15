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
 

    @xlocality_providers = Provider.where(:id => @locality_provider_ids).order(:name)
    @xpost_code_providers = Provider.where(:id => @post_code_provider_ids).order(:name)
    @xstate_providers = Provider.where(:id => @state_provider_ids).order(:name)


     # Refined queries, based on services offered by providers
    rqry = {}
     
     if params[:air_conditioning] and !params[:air_conditioning].empty?
       rqry.merge! air_conditioning: params[:air_conditioning]
     end
     
     if params[:bus_service] and !params[:bus_service].empty?
       rqry.merge! bus_service: params[:bus_service]
     end
     
     if params[:disposable_nappies] and !params[:disposable_nappies].empty?
       rqry.merge! disposable_nappies: params[:disposable_nappies]
     end
     
     if params[:cloth_nappies] and !params[:cloth_nappies].empty?
       rqry.merge! cloth_nappies: params[:cloth_nappies]
     end
     
     if params[:excursions] and !params[:excursions].empty?
       rqry.merge! excursions: params[:excursions]
     end
     
     if params[:extended_hours_for_kindys] and !params[:extended_hours_for_kindys].empty?
       rqry.merge! extended_hours_for_kindys: params[:extended_hours_for_kindys]
     end
     
     if params[:food_provided] and !params[:food_provided].empty?
       rqry.merge! food_provided: params[:food_provided]
     end
     
     if params[:guest_speakers] and !params[:guest_speakers].empty?
       rqry.merge! guest_speakers: params[:guest_speakers]
     end
     
     if params[:languages] and !params[:languages].empty?
       rqry.merge! languages: params[:languages]
     end
     
     if params[:real_grass] and !params[:real_grass].empty?
       rqry.merge! real_grass: params[:real_grass]
     end
     
     if params[:secure_access] and !params[:secure_access].empty?
       rqry.merge! secure_access: params[:secure_access]
     end
     
     if params[:siblings_given_priority] and !params[:siblings_given_priority].empty?
       rqry.merge! siblings_given_priority: params[:siblings_given_priority]
     end
     
     if params[:technology] and !params[:technology].empty?
       rqry.merge! technology: params[:technology]
     end
     
     if params[:vaccinations_compulsory] and !params[:vaccinations_compulsory].empty?
       rqry.merge! vaccinations_compulsory: params[:vaccinations_compulsory]
     end
     
     if params[:waitlist_online] and !params[:waitlist_online].empty?
       rqry.merge! waitlist_online: params[:waitlist_online]
     end
     
     if params[:waitlist_reimbursed] and !params[:waitlist_reimbursed].empty?
       rqry.merge! waitlist_reimbursed: params[:waitlist_reimbursed]
     end
     
     # @refined_providers = @providers.where rqry

    
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
