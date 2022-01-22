class Public::HomesController < ApplicationController
  def top
    @item=Item.all
    @genres=Genre.all
  end

  def about
  end
end
