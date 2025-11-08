class AddAuthorIdToBooks < ActiveRecord::Migration[8.0]
  def change
    add_reference :books, :author, null: true, foreign_key: true, index: true
  end
end
