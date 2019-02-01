class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.boolean :survey_id
      t.integer :question_id
      t.text :question

      t.timestamps
    end
  end
end
