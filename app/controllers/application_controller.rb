class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protect_from_forgery with: :exception

  helper_method :current_customer

  def current_customer
    if session[:sutomer_id]
      @customer = Customer.find(session[:customer_id])
    else
      @customer = Customer.create
      session[:customer_id] = @customer.id
    end
  end
  
  protected
 def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up) do |customer_params|
    user_params.permit(:last_name, :first_name, :last_name_name, :first_name_kana, :postal_code, :address, :telephone_number)
  end
 end
end
