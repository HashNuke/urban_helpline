class PhoneCall
  include Mongoid::Document
  include Mongoid::Timestamps

  field :phone, type: String
  field :provider_unique_id, type: String
  field :duration, type: Integer

  #NOTE possible values
  #     in-progress: in progress phone call
  #     completed: completed phone call
  field :status, type: String, default: "in-progress"

  belongs_to :user
end
