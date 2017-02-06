class RenameCollectionAssociation < ActiveRecord::Migration[5.0]
  def change
    rename_column :books, :collection_id, :book_collection_id
  end
end
