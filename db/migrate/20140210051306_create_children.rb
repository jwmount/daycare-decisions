class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :surname
      t.string :fist_name
      t.string :nick_name
      t.datetime :born_on
      t.references :family, polymorphic: true, index: true

      t.timestamps
    end
  end
end
