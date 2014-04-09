class HomeController < ApplicationController

  def index

    qry = {}

    unless params[:locality].empty?
      qry.merge! locality: params[:locality].upcase
    end
    unless params[:post_code].empty?
      qry.merge! post_code: params[:post_code]
    end
    unless params[:state].empty?
      qry.merge! state: params[:state]               
    end

  	@addresses = Address.where qry
    provider_ids = []

    @addresses.each do |a|
      provider_ids << a.addressable_id
    end
    #@providers = Provider.find provider_ids
    @providers = Provider.where(:id => provider_ids)

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

    @refined_providers = @providers.where rqry

   debugger 

    respond_to do |format|
      format.html
      format.json { render json: [@providers, @favorites, @latest] }
    end
  end 

  def edit
  	debugger
  end

  def update
  	debugger
  end

end
