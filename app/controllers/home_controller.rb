class HomeController < ApplicationController

  def index
  	@addresses = Address.where(locality: "BRISBANE")
    @providers = []
    @addresses.each do |a|
    	@providers << Provider.where(id: a.addressable_id)
    end

    respond_to do |format|
      format.html
      format.json { render json: @companies }
    end
  end

  def edit
  	debugger
  end

  def update
  	debugger
  end

end
