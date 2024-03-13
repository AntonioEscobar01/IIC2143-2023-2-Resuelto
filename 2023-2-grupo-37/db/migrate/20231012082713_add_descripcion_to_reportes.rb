class AddDescripcionToReportes < ActiveRecord::Migration[7.0]
  def change
    add_column :reportes, :descripcion, :text
  end
end
