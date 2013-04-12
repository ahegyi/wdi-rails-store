class Product < ActiveRecord::Base
  attr_accessible :name, :price, :body, :image_url, :in_cart

  has_many :reviews
end
