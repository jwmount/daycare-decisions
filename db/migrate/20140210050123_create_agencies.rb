class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :description
      t.string :governing_body
      t.string :jurisdiction

      t.timestamps
    end
  end
end
