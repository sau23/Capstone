class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    drop_table :feedbacks

    create_table :feedbacks do |t|
      t.string :user_id
      t.text :feedback

      t.timestamps
    end
  end
end
