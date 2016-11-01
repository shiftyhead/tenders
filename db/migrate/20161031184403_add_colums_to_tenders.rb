class AddColumsToTenders < ActiveRecord::Migration[5.0]
  def change
    add_column :tenders, :status, :integer
    add_column :tenders, :region, :integer
    add_column :tenders, :item_count, :integer, limit: 8
    add_column :tenders, :items_count, :integer, limit: 8
    add_column :companies, :region_id, :text
  end
end
