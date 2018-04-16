class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :nickname
      t.string :gender
      t.string :qq
      t.string :wechat
      t.string :city
      t.string :email

      t.timestamps
    end
  end
end
