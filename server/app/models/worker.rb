class Worker
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :username, type: String, default: 'user'
  field :name, type: String
  field :surname, type: String
  field :age, type: Integer
  field :domain, type: String
  field :email, type: String, default: ""
  field :phone, type: String
  field :address, type: String
  field :password_digest
  has_secure_password
  # field :admin, type: Boolean, default: false
end
