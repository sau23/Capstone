json.extract! question, :id, :is_gamified, :question_id, :to_ask, :option_1, :option_2, :option_3, :created_at, :updated_at
json.url question_url(question, format: :json)
