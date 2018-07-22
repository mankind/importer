class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordInvalid do |exception|
    invalid_record(exception)
  end

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_current_model_user

  helper_method :set_current_model_user

  
  def set_current_model_user
    if current_user.present?
      Current.user ||= current_user
    end
  end

  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def invalid_record(error)
    redirect_to root_url, notice: "#{error}"
  end

end
