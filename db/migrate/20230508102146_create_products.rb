class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, limit: 100, null: false, index: { unique: true, name: 'unique_names' }
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :photo_url, null: false
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
