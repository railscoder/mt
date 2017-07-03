class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.string :value, null: false

      t.timestamps
    end

    add_reference :emails, :company, foreign_key: true
  end
end
