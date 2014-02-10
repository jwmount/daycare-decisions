class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer :company_id
      t.string :name
      t.string :type_of_care
      t.string :NQS_rating
      t.string :languages
      t.string :url

      t.timestamps
    end
  end
end
