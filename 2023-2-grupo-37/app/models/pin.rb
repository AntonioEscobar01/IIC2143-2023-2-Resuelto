class Pin < ApplicationRecord
  has_one_attached :image
  has_many_attached :pictures

  def image_as_thumbnail 
    image.variant(resize_to_limit: [300, 300]).processed
  end
end
