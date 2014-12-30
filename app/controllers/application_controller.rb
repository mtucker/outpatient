class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin!
   redirect_to new_user_session_path unless current_user.type == 'Administrator'
  end

  protected

  def after_sign_in_path_for(resource)
    # return the path based on resource
    if(resource.type == 'Administrator')
      '/admin'
    else
      "#{url_for(resource)}/home"
    end
  end

end
