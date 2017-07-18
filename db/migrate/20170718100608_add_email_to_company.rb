class AddEmailToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :email, :string, unique: true, index: true
    add_column :companies, :sended, :boolean, default: false
  end
end
