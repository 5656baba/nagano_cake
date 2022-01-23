class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  attachment :image

  def tax_price
    (price*1.1).round
  end

  # def self.search(keyword)
  #   where(["name like?", "%#{keyword}%"])
  # end

 def self.search(search)
    if search
      Item.where(['name LIKE ?', "%#{search}%"])
    else
      Item.all
    end
 end

end
