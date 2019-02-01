class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.text :user_id
      t.text :feedback

      t.timestamps
    end
  end
end
