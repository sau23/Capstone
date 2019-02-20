class CreateOptionals < ActiveRecord::Migration[5.2]
  def change

    create_table :optionals do |t|
      t.text :user_id
      t.boolean :is_gamified
      t.text :response

      t.timestamps
    end
  end
end
