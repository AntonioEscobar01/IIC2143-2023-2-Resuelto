require "test_helper"

class ReporteTest < ActiveSupport::TestCase

  test "reporte debe tener un producto asociado" do
    @reporte = Reporte.new(producto_id: 99, user_id: 1, descripcion: "[REDACTED]")
    assert_not @reporte.valid?
    assert_nil @reporte.producto
  end

  # mejor hacerlo con setup

  test "reportes son asociados al usuario denunciante" do
    @reporte = Reporte.new(producto_id: 1, user_id: 99, descripcion: "[REDACTED]")
    assert_not @reporte.valid?
    assert_nil @reporte.user
  end

  #mejor hacerlo en setup

  test "descripción debe tener menos de 200 caracteres" do
    @reporte = reportes(:reporte_2)
    resultado = @reporte.save
    assert_not resultado
  end
end
