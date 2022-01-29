class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    #params[:order_detail][:production_status]=params[:order_detail][:production_status].to_i
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    #order=order_detail.order.id
    if order_detail.production_status=="in_production"
      order_detail.order.update(order_status:"in_production")
    elsif order_detail.production_status=="production_complete"
      order_detail.order.update(order_status:"preparing_delivery")
    else
      order_detail.update(order_detail_params)
    end
    redirect_to admin_order_path(order_detail.order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status, :item_id, :order_id)
  end
end
