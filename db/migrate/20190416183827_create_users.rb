class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :user_id
      t.boolean :is_gamified
      t.integer :age
      t.text :gender
      t.text :department
      t.text :role
      t.text :years_worked
      t.integer :completed

      t.timestamps
    end
  end
end
