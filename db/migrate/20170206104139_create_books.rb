class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.belongs_to :author, foreign_key: true
      t.belongs_to :collection, foreign_key: true

      t.timestamps
    end
  end
end
