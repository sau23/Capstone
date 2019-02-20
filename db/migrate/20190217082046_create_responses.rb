class CreateResponses < ActiveRecord::Migration[5.2]
  def change

    create_table :responses do |t|
      t.boolean :is_gamified
      t.integer :question_id
      t.text :user_id
      t.integer :selection
      t.text :response_text

      t.timestamps
    end
  end
end
