class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize!

  def index
    @users_count = User.count
    @documents_count = Document.count
    @documents_for_review = Document.where(review: true).count
  end
end
