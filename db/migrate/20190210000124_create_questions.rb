class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    drop_table :questions

    create_table :questions do |t|
      t.integer :question_id
      t.text :question
      t.text :option_1
      t.text :option_2
      t.text :option_3
      t.text :option_4

      t.timestamps
    end
  end
end
