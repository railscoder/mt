class AddSendedFieldToEmail < ActiveRecord::Migration[5.0]
  def change
    add_column :emails, :sended, :boolean, default: false
  end
end
