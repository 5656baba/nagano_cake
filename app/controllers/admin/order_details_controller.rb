class Admin::OrderDetailsController < ApplicationController
  def update
    #params[:order_detail][:production_status]=params[:order_detail][:production_status].to_i
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    order=order_detail.order.id
    redirect_to admin_order_path(order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status, :item_id, :order_id)
  end
end
