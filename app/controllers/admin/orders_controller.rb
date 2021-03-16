class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order.id)
  end

  private
  def order_params
    params.require(:order).permit(:name, :address, :postal_code, :address_id, :payment_method, :status )
  end
  def address_params
    params.require(:address).permit(:name, :address, :postal_code )
  end
end
