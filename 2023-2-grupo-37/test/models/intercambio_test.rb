require "test_helper"

class IntercambioTest < ActiveSupport::TestCase

  test "un intercambio pertenece a un producto" do
    @intercambio = intercambios(:intercambio_1)
    @producto = productos(:producto_1)
    assert_equal @intercambio.producto, @producto
  end

  test "un intercambio debe poseer un producto" do
    # Instancie el intercambio acá y no en las fixtures porque se levantaba un RunTimeError
    # si colocaba un producto no existente en la base de datos
    @intercambio = Intercambio.new(producto_id: 99, estado: "pendiente")
    assert_not @intercambio.valid?
    assert_nil @intercambio.producto
  end

end
