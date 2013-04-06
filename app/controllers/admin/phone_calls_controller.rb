class Admin::PhoneCallsController < AdminController
  def handle
  end

  def index
    @phone_calls = PhoneCall.order_by(created_at: :desc).page(params[:page])
  end
end
