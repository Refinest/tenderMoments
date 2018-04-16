class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :diary_id

      t.timestamps
    end
  end
end
