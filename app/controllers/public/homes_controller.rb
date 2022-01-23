class Public::HomesController < ApplicationController
  def top
    @item=Item.first(4)
    @genres=Genre.all
  end

  def about
  end
end
