class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :password
      t.text :bio
      t.string :image
      t.string :location

      t.timestamps
    end
  end
end
