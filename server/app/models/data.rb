class Data
  include Mongoid::Document
  belongs_to :patient

  field :PaO2, type: BigDecimal
  field :FiO2, type: BigDecimal
  field :PLT, type: BigDecimal
  field :BIL, type: BigDecimal
  field :PCT, type: BigDecimal
  field :GCS, type: Integer
  field :MAP, type: Boolean
  field :CR, type: BigDecimal
  field :UoP, type: Integer
  field :Ventilation, type: Boolean
  field :Location, type: Integer
  field :Inflammation, type: Integer
  field :Organism, type: Integer
end
