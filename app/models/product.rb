class Product < ActiveRecord::Base
  attr_accessible :name, :price, :body, :image_url, :in_cart

  has_many :reviews

  validates_uniqueness_of :name
  validates :name, :price, :presence => true

  def average_rating
    (self.reviews.map {|review| review.rating }.reduce(:+)) / self.reviews.count.to_f
  end

end
