class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :symbol, null: false, length: 5, index: true, unique: true
      t.string :name, null: false, length: 25, index: true, unique: true
      t.string :position, null: false, length: 10, index: true
      t.integer :type_id, null: false, length: 10, index: true
    end
  end
end
