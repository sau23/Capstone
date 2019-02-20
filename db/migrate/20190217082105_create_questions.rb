class CreateQuestions < ActiveRecord::Migration[5.2]
  def change

    create_table :questions do |t|
      t.integer :question_id
      t.text :to_ask
      t.text :option_1
      t.text :option_2
      t.text :option_3

      t.timestamps
    end
  end
end
