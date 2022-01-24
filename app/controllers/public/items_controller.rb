class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!,except: [:index]

  def index
    @genres = Genre.all
    @items = Item.where(genre_id: params[:genre_id]).page(params[:page]).per(8)  #genreで検索した時
    if @items.empty?
      @items = Item.all.page(params[:page]).per(8)
    else
      @genre = Genre.find(params[:genre_id])
    end

  end

  def show
    @item=Item.find(params[:id])
    @genres=Genre.all
    @cart_item=CartItem.new
  end

  def search
    @genres=Genre.all
    params[:keyword] # 商品名で検索した場合
    @items = Item.search(params[:keyword]).page(params[:page])
    @keyword = params[:keyword]
    render "index"
  end
end
