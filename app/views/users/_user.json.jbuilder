json.extract! user, :id, :user_id, :is_gamified, :gender, :age, :department, :is_surgical_specialist, :role, :years_worked, :created_at, :updated_at
json.url user_url(user, format: :json)
