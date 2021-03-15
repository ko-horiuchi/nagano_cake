class Public::OrdersController < ApplicationController

  def new
    @customer = current_customer
    @order = Order.new
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order.shipping_cost = 800
  end

  def confirm
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    @order.total_payment = 0
    @cart_items = current_customer.cart_items.all
    if params[:address_selection].to_i == 0
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name, current_customer.first_name
      @order.address = current_customer.address
    elsif params[:address_selection].to_i == 1

    elsif params[:address_selection].to_i == 2
      @order = Address.new(address_params)
    end
    session[:order] = @order
  end

  def complete
    @order = Order.new(session[:order])
    @order.customer_id = current_customer.id
    @order.save
    current_customer.cart_items.each do |cart_item|
      # making_statusはenumがまだ作られていないので後で作り直す。enumを作るとエラーになるので注意。
      @order_detail = OrderDetail.new(price: cart_item.item.price, amount: cart_item.amount, making_status: 0, item_id: cart_item.item_id, order_id: @order.id)
      @order_detail.save
      cart_item.destroy
    end
  end



  private
  def order_params
    params.require(:order).permit(:name, :address, :postal_code, :address_id, :payment_method )
  end
  def address_params
    params.require(:address).permit(:name, :address, :postal_code )
  end

end
