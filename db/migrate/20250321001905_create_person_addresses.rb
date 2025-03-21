class CreatePersonAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :person_addresses do |t|
      t.string :street, null: false, limit: 255
      t.string :city, null: false, limit: 255
      t.string :state, null: false, limit: 255
      t.integer :postal_code, null: false
      t.string :country, null: false, limit: 255

      t.references :person, null: false, index: true, foreign_key: { to_table: :persons }

      t.boolean :active, index: true, default: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
