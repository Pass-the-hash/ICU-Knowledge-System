class Patient
  include Mongoid::Document
  # has_many :data

  field :AMKA, type: String
  field :name, type: String
  field :surname, type: String
  field :age, type: Integer
  field :conditions, type: Array, default: []
  field :hospitalized, type: Boolean
  field :sex, type: String
end
