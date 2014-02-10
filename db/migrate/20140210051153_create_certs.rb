class CreateCerts < ActiveRecord::Migration
  def change
    create_table :certs do |t|
      t.datetime :expires_on
      t.boolean :active
      t.references :person, polymorphic: true, index: true
      t.references :company, polymorphic: true, index: true
      t.references :provider, polymorphic: true, index: true
      t.references :agency, polymorphic: true, index: true

      t.timestamps
    end
  end
end
