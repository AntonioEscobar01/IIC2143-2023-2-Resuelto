class AddNuevoAtributoToReportes < ActiveRecord::Migration[7.0]
  def change
    add_column :reportes, :nuevo_atributo, :string
  end
end
