class AddTypeToTenders < ActiveRecord::Migration[5.0]
  def change
    add_column :tenders, :category, :integer
  end
end
