class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.boolean :active
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
