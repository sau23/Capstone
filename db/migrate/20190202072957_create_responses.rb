class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    drop_table :responses

    create_table :responses do |t|
      t.boolean :survey_id
      t.integer :question_id
      t.string :user_id
      t.integer :response
      t.text :response_text

      t.timestamps
    end
  end
end
