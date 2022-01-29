class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

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
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(item.id)
    else
      render :edit
    end
  end

  def search
    params[:keyword] # 商品名で検索した場合
    @items = Item.search(params[:keyword]).page(params[:page])
    @keyword = params[:keyword]
    render "index"
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
end
