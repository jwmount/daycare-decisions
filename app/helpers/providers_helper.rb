module ProvidersHelper

  
  # Only PROXY of this so far, need to use guardians_providers model
  def favorites
  	count = Provider.count.to_i

    @favorite_ids = []
    6.times do |i|
      @favorite_ids << rand(1...count)
    end
    favorites = Provider.find @favorite_ids
  end

  # Get the 6 most recently changed or updated.  
  # 6 is a randomly chosen value.
  def latest
    latest = Provider.select("id, name, url, updated_at").order(:updated_at).limit(6)
  end

  def provider_list area, ids
    
    return "No providers were found in #{params["#{area}"]}.", '', [] if ids.empty?
  
    @services_requested, @requested, @qry = list_services(params)

    @r1 = "There are #{ids.count} providers in #{params["#{area}"]}."
     if !@services_requested
      providers = Provider.where(:id => ids).order(:name)
      return @r1, '', providers
    end

    @qry
    providers = Provider.where(:id => ids).where(@qry).order(:name)

    @r2 = "None of the providers in #{params["#{area}"]} offer #{@requested}."
    return @r1, @r2, [] if @services_requested and providers.empty?

    @r2 = "Providers with #{@requested} are:"
    return @r1, @r2, providers
  end

  def post_code_providers
    Provider.where(:id => @post_code_provider_ids).where(@rqry).order(:name)
  end

  def state_providers
    Provider.where(:id => @state_provider_ids).where(@rqry).order(:name)
  end

  # Return if a list of services is wanted, and a string to display these.
  def list_services params
    services = []
    rqry = {}
    @keys = params.except :utf8, :commit, :action, :controller, :locality, :post_code, :state
    @keys.each do |k,v|
      services << "#{k}".sub('_',' ')
      rqry["#{k}"] = true
    end
    return !services.empty? ?  true : false, services.join(', '), rqry
  end

end


