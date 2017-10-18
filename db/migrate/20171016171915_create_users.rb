class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :uid, null: false
      t.string :provider, null: false

      t.timestamps
    end
  end
end
