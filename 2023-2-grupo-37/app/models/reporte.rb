class Reporte < ApplicationRecord
  belongs_to :producto
  belongs_to :user

  validates :descripcion, length: { maximum: 200 }

  after_create :verificar_reportes

  private

  def verificar_reportes
    if producto.reportes.count >= 3
      producto.destroy
    end
  end
end