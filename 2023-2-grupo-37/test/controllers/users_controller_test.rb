require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @usuario_1 = users(:user_1)
    sign_in @usuario_1
    @usuario_2 = users(:user_4)
    sign_in @usuario_2
    @usuario_1.save
    @usuario_2.save
    @producto_favorito = productos(:producto_1)
    @producto_favorito.save
    @usuario_1.productos_fav[@producto_favorito.id] = @producto_favorito
    @usuario_3 = users(:user_6)
    @usuario_3.save
  end 

  test "Comprobar que metodo show funcione correctamente" do
    get user_path(@usuario_1.id)
    assert_response :success
  end
  
  test "debe eliminar correctamente a un usuario y solo un usuario" do
    assert_difference('User.count', -1) do
      get eliminar_usuario_path(@usuario_2.id)
    end
    assert_redirected_to root_path
  end

  test "redirecciona a la pagina de inicio al actualizar un usuario" do
    patch actualizar_usario_path(@usuario_1), params: { user: { name: "Nuevo Nombre" } }
    assert_redirected_to root_path
    assert_equal "Usuario actualizado exitosamente.", flash[:notice]
  end

  test "Un usuario no registrado puede utilizar la página de visita" do
    get ver_usuario_path(@usuario_3.id)
    assert_response :success
    assert_not flash[:alert]
  end

  test "Al calificar un usuario se redirige correctamente" do
    post calificar_usuario_path(@usuario_3.id), params: { calificacion: 5 }
    assert_redirected_to root_path
    assert_equal "Calificación actualizada exitosamente.", flash[:notice]
  end
  
  test "Los usuarios pueden acceder a la sección de favoritos" do
    get mostrar_favoritos_path(@usuario_1.id)
    assert_response :success
  end

  test "no se puede calificar a un usuario si no se ha inciado sesión" do
    sign_out @usuario_2
    post calificar_usuario_path(@usuario_1.id), params: { calificacion: 5 }
    assert_redirected_to root_path
  end

  test "los usuarios puede editar su perfil" do
    get editar_usuario_path(@usuario_1.id)
    assert_response :success
  end

end
