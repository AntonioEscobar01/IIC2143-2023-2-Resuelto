require "test_helper"

class ReportesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @usuario = users(:user_1)
    sign_in @usuario
    @producto = productos(:producto_1)
    @producto.save
    @producto_new = productos(:producto_6)
    @producto_new.save
    @reporte_1 = reportes(:reporte_1)
    @reporte_1.save
    @reporte_2 = reportes(:reporte_3)
    @reporte_2.save
    @reporte_3 = reportes(:reporte_4)
    @reporte_3.save
    @producto_r = productos(:producto_5)
    @producto_r.save
    @reporte_r = reportes(:reporte_5)
  end

  test "debe mostrar los reportes asociados al producto correspondiente" do
    get ver_reportes_path(@reporte_1.producto_id)
    assert_response :success
  end

  test "verificar que el reporte se cree y rediriga correctamente" do
    get nuevo_reporte_path(@producto_new.id), params: { reporte: { producto_id: @producto_new.id, 
      user_id: 1, descripcion: "Un nuevo reporte" } }
    assert_response :success

    post crear_reporte_path(@producto_new.id), params: { reporte: { producto_id: @producto_new.id, 
      user_id: 1, descripcion: "Un nuevo reporte" } }
    assert_redirected_to @producto_new
    assert_equal 'Reporte enviado con éxito.', flash[:notice]
  end

  #test "verificar que el reporte se actualice correctamente" do
  #  @reporte = reportes(:reporte_1)
  #  @reporte.save
  #  get editar_reporte_path(@reporte.id), params: { reporte: { producto_id: @reporte.producto_id,
  #    user_id: @reporte.user_id, descripcion: @reporte.descripcion } }
  #  assert_response :success
  #  end
  
  test "eliminar producto si tiene 3 o más reportes" do
    @reporte = reportes(:reporte_1)
    @reporte.save
    @reporte2 = reportes(:reporte_3)
    @reporte2.save
    @reporte3 = reportes(:reporte_4)
    @reporte3.save
    @producto = productos(:producto_1)
    @producto.save
    @producto.reportes << @reporte
    @producto.reportes << @reporte2
    post crear_reporte_path(@producto.id), params: { reporte: { producto_id: @producto.id, 
      user_id: 5, descripcion: '[REDACTED]' } }
    assert_redirected_to productos_path
    assert_equal 'El producto ha sido eliminado debido a que ha superado el número máximo de reportes.', flash[:notice]
  end

  test "es posible eliminar un reporte" do
    @reporte = reportes(:reporte_1)
    @reporte.save
    get eliminar_reporte_path(@reporte.id)
    assert_equal 'Reporte eliminado con éxito.', flash[:notice]
  end

  def teardown
    Rails.cache.clear
    sign_out @usuario
  end
 
end
