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
    @providers = []

    @addresses.each do |a|
      @providers << Provider.where(id: a.addressable_id)
    end

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
