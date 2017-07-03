class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.string :value, null: false

      t.timestamps
    end

    add_reference :phones, :company, foreign_key: true
  end
end
