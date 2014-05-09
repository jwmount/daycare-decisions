module ApiHelper


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

  def XXpost_code_providers
    Provider.where(:id => @post_code_provider_ids).where(@rqry).order(:name)
  end

  def XXstate_providers
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
