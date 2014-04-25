class ApiController < ApplicationController
  include ActionController::MimeResponds

  def index
    @providers = Provider.all
    render json: [params, @providers]
  end

  def show
  	@providers = Provider.find params[:id]
    render json: [params, @providers]
  end

  
end
