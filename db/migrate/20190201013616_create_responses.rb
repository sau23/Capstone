class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.boolean :survey_id
      t.integer :question_id
      t.text :user_id
      t.integer :response
      t.text :response_text

      t.timestamps
    end
  end
end
