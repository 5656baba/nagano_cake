class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order=Order.new
    @addresses=current_customer.addresses
  end

  def index
    @orders=current_customer.orders
  end

  def show
    @order=Order.find(params[:id])
    @order_details=OrderDetail.all
  end

  def check
    @sipping_fee=800
    @cart_items=CartItem.all
    @order=Order.new(order_params)
    @order.customer_id=current_customer.id
    @order.payment_method=params[:order][:payment_method]
    if params[:order][:address_option]=="0"  #ラジオボタンの0を選んだら
      @order.delivery_postal_code=current_customer.postal_code   #各値の紐づけ  以下同文
      @order.delivery_address=current_customer.address
      @order.delivery_name=current_customer.last_name+current_customer.first_name
    elsif params[:order][:address_option]=="1"
      address=Address.find(params[:order][:address_id])
      @order.delivery_postal_code=address.postal_code
      @order.delivery_address=address.address
      @order.delivery_name=address.name
    elsif params[:order][:address_option]=="2"
      @order.delivery_postal_code=params[:order][:delivery_postal_code]
      @order.delivery_address=params[:order][:delivery_address]
      @order.delivery_name=params[:order][:delivery_name]
    end
  end

  def complete
  end

  def create
    order=Order.new(order_params)
    order.save
    @cart_items=current_customer.cart_items  #createはnewとsave一緒に行うメソッド
    @cart_items.each do |cart_item|
      OrderDetail.create(
        item_id: cart_item.item.id,
        order_id: order.id,
        amount: cart_item.amount
      )
    end
    @cart_items.destroy_all
    redirect_to complete_orders_path
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :delivery_postal_code, :delivery_address, :delivery_name, :sipping_fee, :billing_amount, :customer_id)
  end
end
