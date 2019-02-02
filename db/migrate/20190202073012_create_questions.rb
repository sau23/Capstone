class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    drop_table :questions

    create_table :questions do |t|
      t.boolean :survey_id
      t.integer :question_id
      t.text :question

      t.timestamps
    end
  end
end
