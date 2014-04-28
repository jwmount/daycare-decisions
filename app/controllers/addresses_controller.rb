class AddressesController < ApplicationController
  include ActionController::MimeResponds

  def index
  	@addresses = Address.all
  	render json: [params, @addresses]
  end

  def show
  	@address = Address.find params[:id]
    render json: [params, @address]
  end

end