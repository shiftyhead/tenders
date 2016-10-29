class ChangeColName < ActiveRecord::Migration[5.0]
  def change
    rename_column :tenders, :company_id_id, :company_id
  end
end
