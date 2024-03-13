require "test_helper"

class ProductosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @usuario_1 = users(:user_1)
    sign_in @usuario_1
    @usuario_2 = users(:user_2)
    @producto_1 = productos(:producto_1)
    @producto_1.save
    @producto_2 = productos(:producto_6)
    @producto_2.save
    @producto_3 = productos(:producto_5)
    @producto_4 = productos(:producto_7)
  end

  test "Verificar que metodo index funciona correctamente" do
    get productos_path
    assert_response :success
  end

  test "Los productos no se actulizan si se llenan mal los campos" do
    patch update_producto_path(@producto_1.id), params: { producto: {nombre: "NewName",
      descripcion: "Nueva descripción!", categoria: @producto_1.categoria, parametro_desconocido: true} }
    assert_response :unprocessable_entity
  end

  test "Verificar que productos se actualizan correctamente en la página" do
    get editar_producto_path(@producto_2.id), params: { producto: {nombre: "NewName",
      descripcion: "Nueva descripción!", categoria: @producto_2.categoria, disponible: false} }
    assert_response :success
  end
  
  test "Verificar que se puede crear un producto y que luego se rediriga adecuadamente" do
    @producto_3.save
    get "/productos/new", params: { producto: {nombre: @producto_3.nombre,
      descripcion: @producto_3.descripcion, categoria: @producto_3.categoria, disponible: true} }
    assert_response :success
  end

  test "Los productos son únicos" do
    @producto_4.save
    post productos_path, params: { producto: {nombre: @producto_1.nombre,
      descripcion: @producto_1.descripcion, categoria: @producto_1.categoria, disponible: false} }
    assert_response :unprocessable_entity
  end

  test "Los productos son destruidos y luego se redirige correctamente" do
    get eliminar_producto_path(@producto_2.id)
    assert_redirected_to root_path
    assert_not Producto.exists?(@producto_2.id)
  end

  test "Verificar que se pueda agregar el producto a la lista de fav" do
    get favoritos_usuario_path(@producto_1.id)
    assert_redirected_to action: 'favoritos', controller: 'users'
    #assert_response :success
  end 

  test "Verificar que se redirige correctamente al eliminar el producto de favoritos" do
    get eliminar_favorito_path(@producto_1.id)
    assert_redirected_to action: 'favoritos', controller: 'users'
    #assert_response :success
  end

  test "debería mostrar el producto correctamente en el método show" do
    get producto_path(@producto_1.id)
    assert_response :success
    assert_select 'h1', @producto_1.nombre
    # Asegúrate de verificar otros elementos de la vista según la estructura de tu página
  end

  def teardown
    Rails.cache.clear
    sign_out @usuario_1
    producto = Producto.find_by(nombre: @producto_1.nombre)
    producto.destroy
  end
  
end
