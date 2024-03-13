class CreateReportes < ActiveRecord::Migration[7.0]
  def change
    create_table :reportes do |t|
      t.references :producto, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
