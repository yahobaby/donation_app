class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # フォームから送信されるパラメーターを受け取るために、ストロングパラメーターを設定
  # deviseに関するストロングパラメーターは、application_controller.rbに記述


  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_reading, :nickname])
  end
  # :email、:password、:password_confirmationは記述しません。これらのパラメーターに関しては、デフォルトで設定されているため
end
