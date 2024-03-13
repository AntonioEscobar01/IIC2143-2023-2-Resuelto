class User < ApplicationRecord
  has_many :productos, dependent: :destroy 
  has_many :intercambios, through: :productos, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :all_except, ->(user) { where.not(id: user)}
  after_create_commit { broadcast_append_to "users"}
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  after_initialize :inicializar_favs
  
  has_one_attached :image
  # validates :image, attached: true, content_type: ['image/jpeg', 'image/png', 'image/jpg']

  def inicializar_favs
    self.productos_fav ||= {}
  end

  def image_as_thumbnail 
    image.variant(resize_to_limit: [300, 300]).processed
  end

  # attr_accessor :remove_image

  def remove_image
    image.purge_later
  end
end