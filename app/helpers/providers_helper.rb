module ProvidersHelper

  def count
    100
  end
  
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

  def xlatest
  	count = Provider.count.to_i

    latest_ids = []
    6.times do |i|
      latest_ids << rand(1...count)
    end
    latest = Provider.find latest_ids
  end  

  def locality_providers
    Provider.where(:id => @locality_provider_ids).order(:name)
  end

  def post_code_providers
    Provider.where(:id => @post_code_provider_ids).order(:name)
  end

  def state_providers
    Provider.where(:id => @state_provider_ids).order(:name)
  end
end
