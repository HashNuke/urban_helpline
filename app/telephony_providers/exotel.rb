module UrbanHelpline
  class ExotelProvider
    def self.add_number(number)
    end

    def self.enable_number(number)
    end

    def self.disable_number(number)
    end

    def self.create_call_from_webhook(params)
      return unless ["free", "busy"].include?(params["Status"])
      attributes = self.send("parse_#{params["Status"]}_webhook", params)
      phone_call = PhoneCall.create(attributes)
      phone_call.save
    end

    private

    def self.parse_busy_webhook(params)
    end

    def self.parse_attended_webhook(params)
      {
        operator_email: params["AgentEmail"]
        operator_phone: params["DialWhomNumber"]
        phone: params["CallFrom"]
        provider_call_id: params["CallSid"]
        status: "attended"
      }
    end
  end
end
