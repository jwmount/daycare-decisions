class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :suburb
      t.string :state
      t.string :post_code
      t.string :lat
      t.string :long
      t.references :provider, polymorphic: true, index: true
      t.references :person, polymorphic: true, index: true
      t.references :company, polymorphic: true, index: true

      t.timestamps
    end
  end
end
