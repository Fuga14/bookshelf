class CreateImports < ActiveRecord::Migration[8.0]
  def change
    create_table :imports do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :created_count, default: 0
      t.integer :skipped_count, default: 0
      t.float :execution_time
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
