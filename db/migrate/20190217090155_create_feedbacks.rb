class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change

    create_table :feedbacks do |t|
      t.text :user_id
      t.boolean :is_gamified
      t.integer :experience
      t.integer :difficulty
      t.integer :future

      t.timestamps
    end
  end
end
