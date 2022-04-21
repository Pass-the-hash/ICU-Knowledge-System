class Patient
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :AMKA, type: String
  field :name, type: String
  field :surname, type: String
  field :age, type: Integer
  field :description, type: String
  field :hospitalized, type: Boolean
  field :gender, type: String
end
