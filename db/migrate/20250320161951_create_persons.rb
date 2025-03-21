class CreatePersons < ActiveRecord::Migration[8.0]
  def change
    create_table :persons do |t|
      t.string :name, index: true, null: false, limit: 255
      t.string :email, index: true, null: false, limit: 255
      t.string :phone, index: true, null: false, limit: 255
      t.date :birthdate, index: true, null: false

      t.boolean :active, index: true, default: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
