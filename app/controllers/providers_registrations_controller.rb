class ProvidersRegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :phone, :zip_code, :specialty_id)
  end

end
