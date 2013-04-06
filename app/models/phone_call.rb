class PhoneCall
  include Mongoid::Document
  include Mongoid::Timestamps

  field :phone, type: String
  field :provider_unique_id, type: String

  belongs_to :user
end
