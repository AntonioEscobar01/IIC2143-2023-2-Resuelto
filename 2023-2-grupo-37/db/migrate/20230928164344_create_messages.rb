class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:messages)
      create_table :messages do |t|
        t.references :user, null: false, foreign_key: true
        t.references :room, null: false, foreign_key: true
        t.text :body

        t.timestamps
      end
    end
  end
end
