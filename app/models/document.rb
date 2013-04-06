class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :address, type: String
  field :notes, type: String
  field :review, type: Boolean, default: false
end
