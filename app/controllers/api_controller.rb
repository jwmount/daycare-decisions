//localhost:3000/api => all providers
//localhost:3000/api/20 = provider :id = 20

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
