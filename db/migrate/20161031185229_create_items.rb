class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.references :tender, foreign_key: true
      t.text :content
      t.text :quantity
      t.text :price_one
      t.text :price_all

      t.timestamps
    end
  end
end
