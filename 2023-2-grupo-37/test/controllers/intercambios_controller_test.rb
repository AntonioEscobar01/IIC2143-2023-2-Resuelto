require 'test_helper'

class IntercambiosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @usuario_1 = users(:user_1)
    sign_in @usuario_1
    @producto_1 = productos(:producto_1)
    @producto_2 = productos(:producto_6)
    @intercambio_1 = intercambios(:intercambio_1)
    @intercambio_2 = intercambios(:intercambio_4)
    @intercambio_3 = intercambios(:intercambio_4_copy)
  end

  test "debería ejecutar el método index" do
    get intercambios_path
      assert_response :success
  end

  test 'método create debe funcionar' do
    @producto_1.save
      get crear_intercambio_path(@producto_1.id)
      assert_redirected_to intercambios_path
  end

  test 'los intercambios se deben poder eliminar' do
    @intercambio_1.save
      get eliminar_intercambio_path(@intercambio_1.id)
      assert_redirected_to root_path
  end

  test "no hay intercambios duplicados" do
    @intercambio_2.save
    @intercambio_3.save
    assert_not_equal @intercambio_2, @intercambio_3
  end

  test "los intercambios se pueden llevar a cabo" do
    @intercambio_2.save
    patch update_intercambio_path(@intercambio_2.id), params: { intercambio: { estado: 'Aceptado' } }
  
    follow_redirect!
    assert_match "/intercambios", path
  end

  test "la página de edición de intercambios debe funcionar" do
    @intercambio_2.save
    get editar_intercambio_path(@intercambio_2.id)
    assert_response :success
  end

  def teardown
    Rails.cache.clear
      sign_out @usuario_1
  end
end
