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

  after_create :broadcast_new_call
  after_update :broadcast_call_disconnect

  before_save :ensure_user

  private

  def ensure_user
    user = User.find_by(phone: self[:operator_phone]) rescue false
    return if !user
    self.user_id = user.id
  end

  def broadcast_new_call
    return if self.user_id
    data = {
      :event => "user#new_call",
      :entity => self.attributes
    }
    FAYE_CLIENT.publish "/app/activities", data) if defined?(FAYE_CLIENT)
  end

  def broadcast_call_disconnect
    return if self.status != "completed"
    data = {
      :event => "user#new_call",
      :entity => self.attributes
    }
    FAYE_CLIENT.publish "/app/activities", data  if defined?(FAYE_CLIENT)
  end
end
