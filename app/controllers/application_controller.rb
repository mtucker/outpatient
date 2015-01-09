# Base controller for the Application from whence all other
# controllers inherit. Site-wide controller logic can go here.
class ApplicationController < ActionController::Base

  # Determine if we need to use the a controller-specific layout
  layout :layout_for_controller

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin!
    redirect_to new_user_session_path unless current_user.type == 'Administrator'
  end

  # Override Devise's current_user method so that it accomodates all user types
  alias_method :devise_current_user, :current_user

  def current_user
    if administrator_signed_in?
      current_administrator
    elsif provider_signed_in?
      current_provider
    else
      devise_current_user
    end
  end

  protected

  def after_sign_in_path_for(resource)
    # return the path based on resource
    if (resource.type == 'Administrator')
      '/admin'
    else
      "#{url_for(resource)}/home"
    end
  end

  def layout_for_controller
    if front_of_house_controller?
      'front_of_house'
    else
      'application'
    end
  end

  def front_of_house_controller?
    devise_controller?
  end
end
