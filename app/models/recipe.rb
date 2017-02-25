class Recipe < ApplicationRecord
  searchkick
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  belongs_to :chef
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  validates :name, presence: true
  validates :chef_id, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
end
