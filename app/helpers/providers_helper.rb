module ProvidersHelper

  def favorites
  	count = Provider.count.to_i

    @favorite_ids = []
    6.times do |i|
      @favorite_ids << rand(1...count)
    end
    favorites = Provider.find @favorite_ids
  end


  def latest
  	count = Provider.count.to_i

    latest_ids = []
    6.times do |i|
      latest_ids << rand(1...count)
    end
    latest = Provider.find latest_ids
  end  

end
