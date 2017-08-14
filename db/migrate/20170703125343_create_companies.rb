class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :site, null: false
      t.string :full_url
      t.string :source
      t.text :phones, array: true, default: []

      t.timestamps
    end
  end
end
