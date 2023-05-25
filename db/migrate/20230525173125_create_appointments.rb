class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :window, null: false, foreign_key: true, index: { unique: true }
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
