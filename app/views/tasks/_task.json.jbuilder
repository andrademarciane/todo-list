json.extract! task, :id, :board, :name, :created_at, :updated_at
json.url task_url(task, format: :json)
