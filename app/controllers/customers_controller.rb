class CustomersController < ApplicationController
    before_action :authenticate_customer!,except: [:top, :about, :items_inedx, :items_show]
end
