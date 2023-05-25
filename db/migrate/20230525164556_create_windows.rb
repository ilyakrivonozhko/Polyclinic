class CreateWindows < ActiveRecord::Migration[7.0]
  def change
    create_table :windows do |t|
      t.datetime :datetime, null: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
