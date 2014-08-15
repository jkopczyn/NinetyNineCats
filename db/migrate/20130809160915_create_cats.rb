class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.integer :age, null: false
      t.date :birth_date, null: false
      t.string :color, null: false
      t.string :name, null: false
      t.string :sex, length: 1, null: false
      t.text :description

      t.timestamps
    end
  end
end
