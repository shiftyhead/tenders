class CreateTenders < ActiveRecord::Migration[5.0]
  def change
    create_table :tenders do |t|
      t.string :name
      t.references :company_id
      t.datetime :start_date
      t.datetime :end_date
      t.float :item_price
      t.text :address

      t.timestamps
    end
  end
end
