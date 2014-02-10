class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :certificate_id
      t.integer :for_person
      t.integer :for_company
      t.integer :for_provider
      t.integer :for_person
      t.string :description
      t.references :person, polymorphic: true, index: true
      t.references :company, polymorphic: true, index: true
      t.references :provider, polymorphic: true, index: true
      t.references :agency, polymorphic: true, index: true

      t.timestamps
    end
  end
end
