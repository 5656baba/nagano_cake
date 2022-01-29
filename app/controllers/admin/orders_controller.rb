class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order=Order.find(params[:id])
    @order_details=@order.order_details
  end

  def update
    #params[:order][:order_status]=params[:order][:order_status].to_i
    order = Order.find(params[:id])
    order.update(order_params)
    if order.order_status=="payment_confirmation"
      order.order_details.each do |order_detail|
        order_detail.update(production_status:"production_pending")
      end
    end
    redirect_to admin_order_path(order.id)
  end

  private
  def order_params
    params.require(:order).permit(:order_status, :customer_id)
  end
end
