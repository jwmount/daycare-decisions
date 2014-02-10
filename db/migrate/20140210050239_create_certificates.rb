class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :name
      t.boolean :active
      t.string :description
      t.boolean :for_person
      t.boolean :for_company
      t.boolean :for_provider

      t.timestamps
    end
  end
end
