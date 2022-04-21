class Information
  include Mongoid::Document

  field :AMKA, type: String
  field :conditions, type: Array, default: []
  field :PaO2, type: Array, default: []
  field :FiO2, type: Array, default: []
  field :PLT, type: Array, default: []
  field :BIL, type: Array, default: []
  field :GCS, type: Array, default: []
  field :MAP, type: Array, default: []
  field :CR, type: Array, default: []
  field :UoP, type: Array, default: []
  field :PCT, type: BigDecimal
  field :ventilation, type: Boolean
  field :location, type: Integer
  field :inflammation, type: Integer
  field :organism, type: Integer
  field :dates, type: Array, default: []
end