class Producto < ApplicationRecord
  belongs_to :user
  has_one :intercambio, dependent: :destroy 
  has_many :reportes, dependent: :destroy
  has_one_attached :image, service: :google, dependent: :destroy

  validates :nombre, presence: true, length: { maximum: 100 }
  validates :descripcion, presence: true, length: { maximum: 300 }
  validates :categoria, presence: true
  validates :disponible, inclusion: {in: [false, true]}
  validates :image, presence: true

  def reportes_count
    reportes.count
  end

  def agregar_visita
    self.visitas += 1
    self.save
  end

end
