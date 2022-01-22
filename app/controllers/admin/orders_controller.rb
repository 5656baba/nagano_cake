class Admin::OrdersController < ApplicationController
  def show
    @order=Order.find(params[:id])
    @order_details=OrderDetail.all
  end

  def update
    #params[:order][:order_status]=params[:order][:order_status].to_i
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(order.id)
  end

  private
  def order_params
    params.require(:order).permit(:order_status, :customer_id)
  end
end
