class CreateDirectors < ActiveRecord::Migration[7.0]
  def change
    create_table :directors do |t|
      t.string :name
      t.integer :age
      t.string :country
      t.boolean :has_oscars

      t.timestamps
    end
  end
end
