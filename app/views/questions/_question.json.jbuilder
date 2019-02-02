json.extract! question, :id, :survey_id, :question_id, :question, :created_at, :updated_at
json.url question_url(question, format: :json)
