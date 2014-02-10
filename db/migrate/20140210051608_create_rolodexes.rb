class CreateRolodexes < ActiveRecord::Migration
  def change
    create_table :rolodexes do |t|
      t.string :number_or_email
      t.string :kind
      t.string :when_to_use
      t.string :description
      t.references :person, polymorphic: true, index: true
      t.references :company, polymorphic: true, index: true
      t.references :provider, polymorphic: true, index: true
      t.references :agency, polymorphic: true, index: true

      t.timestamps
    end
  end
end
