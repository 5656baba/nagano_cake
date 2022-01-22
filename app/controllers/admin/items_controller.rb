class Admin::ItemsController < ApplicationController
  def index
    @items=Item.all.page(params[:page]).per(10)
  end

  def show
    @item=Item.find(params[:id])
  end

  def new
    @item=Item.new
  end

  def edit
    @item=Item.find(params[:id])
  end

  def create
    item = Item.new(item_params)
    item.save
    redirect_to admin_item_path(item.id)
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item.id)
  end

  private
  def item_params
    params.require(:item).permit(:image_id, :name, :introduction, :genre_id, :price, :is_active)
  end
end
