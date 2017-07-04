class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :rus_name, null: false
      t.string :eng_name, null: false

      t.timestamps
    end

    add_reference :companies, :city, foreign_key: true
  end
end
