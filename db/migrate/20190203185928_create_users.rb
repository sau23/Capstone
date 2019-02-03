class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :user_id
      t.text :gender
      t.integer :age
      t.text :department
      t.text :clinical_year
      t.integer :completed

      t.timestamps
    end
  end
end
