class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: {unique: true}
      t.string :name
      t.string :surname
      t.string :patronymic
      t.integer :phone_number, null: false, index: {unique: true}
      t.integer :role
      t.string :password_digest

      t.timestamps
    end
  end
end
