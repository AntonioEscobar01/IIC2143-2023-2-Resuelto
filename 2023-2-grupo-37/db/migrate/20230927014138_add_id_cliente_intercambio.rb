class AddIdClienteIntercambio < ActiveRecord::Migration[7.0]
  def change
    add_column :intercambios, :id_cliente, :integer
  end
end
