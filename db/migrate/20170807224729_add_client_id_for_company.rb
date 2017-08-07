class AddClientIdForCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :client_id, :integer
  end
end
