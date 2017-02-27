class Recipe < ApplicationRecord
  searchkick
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  belongs_to :chef
  has_many :recipe_ingredients
  has_many :likes, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy
  default_scope -> { order(updated_at: :desc) }
  validates :name, presence: true
  validates :chef_id, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }

  def thumbs_up_total
    self.likes.where(like: true).size
  end

  def thumbs_down_total
    self.likes.where(like: false).size
  end
end
