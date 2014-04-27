class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
end


ActiveAdmin::Views::Pages::Base.class_eval do

  private

  def build_footer
    div :id => "footer" do
      footer = "#{link_to("Daycare Decisions", "http://www.daycare-decisions.herokuapp.com")} #{ENV['VERSION']};".html_safe
      footer << "  Powered by #{link_to("Active Admin", "http://www.activeadmin.info")} #{ActiveAdmin::VERSION}".html_safe
      para footer
    end
  end
 
end