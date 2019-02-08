class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    drop_table :feedbacks

    create_table :feedbacks do |t|
      t.text :user_id
      t.integer :experience
      t.integer :future
      t.integer :difficulty

      t.timestamps
    end
  end
end
