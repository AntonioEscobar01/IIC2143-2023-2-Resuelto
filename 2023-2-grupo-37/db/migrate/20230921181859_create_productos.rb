class CreateProductos < ActiveRecord::Migration[7.0]
  def change
    create_table :productos do |t|
      t.text :nombre
      t.text :categoria
      t.boolean :disponible

      t.timestamps
    end
  end
end
