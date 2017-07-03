class AddReferenceCompanyToCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :companies, :category, foreign_key: true
  end
end
