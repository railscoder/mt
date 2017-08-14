class AddIndexToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :email, :string
    add_column :companies, :sended, :boolean, default: false

    add_index :companies, [:email, :client_id], unique: true
    add_index :companies, [:site, :client_id], unique: true
  end
end
