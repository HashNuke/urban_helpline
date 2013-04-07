class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search

  validates :name, presence: true
  before_save :ensure_review_is_boolean

  field :name,    type: String
  field :address, type: String
  field :notes,   type: String
  field :review,  type: Boolean, default: false

  search_in :name, :address, :notes

  #NOTE fix for mongoid not handling boolean values properly
  def ensure_review_is_boolean
    self.review = true  if self.review == "1"
    self.review = false if self.review == "0"
    true
  end
end
