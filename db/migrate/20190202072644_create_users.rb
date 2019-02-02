class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :users

    create_table :users do |t|
      t.string :user_id
      t.string :gender
      t.integer :age
      t.string :department
      t.string :clinical_year

      t.timestamps
    end
  end
end
