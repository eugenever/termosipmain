class ErrorsController < ApplicationController
 
  def error_not_found
    render :status => 404, :template => 'errors/not_found', :layout => 'errors'
  end
 
end
