class Product < ApplicationRecord
  validates :name, :price, :photo_url, presence: true
  validates :name, length: { maximum: 100 }
  validates :name, uniqueness: true
  validates :price, numericality: true
end
