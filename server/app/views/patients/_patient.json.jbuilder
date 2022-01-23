json.extract! patient, :id, :name, :surname, :age, :description, :hospitalized, :created_at, :updated_at
json.url patient_url(patient, format: :json)
