class AddNuevoAtributoToProducto < ActiveRecord::Migration[7.0]
  def change
    add_column :productos, :visitas, :integer
  end
end
