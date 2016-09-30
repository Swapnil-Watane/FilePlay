class CreateUpfiles < ActiveRecord::Migration
  def change
    create_table :upfiles do |t|
      t.string :name
      t.string :attachment

      t.timestamps null: false
    end
  end
end
