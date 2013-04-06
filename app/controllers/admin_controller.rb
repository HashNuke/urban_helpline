class AdminController < ApplicationController

  before_filter :authenticate_user!
  before_filter :authorize!

  def index
  end
end
