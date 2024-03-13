class AddDescripcionProducto < ActiveRecord::Migration[7.0]
  def change
    add_column :productos, :descripcion, :text
  end
end
