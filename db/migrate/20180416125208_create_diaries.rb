class CreateDiaries < ActiveRecord::Migration[5.1]
  def change
    create_table :diaries do |t|
      t.string :title, default: Date.new
      t.text :content, null: false
      t.string :weather
      t.string :mood
      t.integer :user_id

      t.timestamps
    end
  end
end
