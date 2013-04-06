class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :permitted_params
  helper_method :is_operator?
  helper_method :is_admin?

  def permitted_params
    @permitted_params ||= PermittedParams.new(params)
  end

  def is_admin?
    current_user.admin?
  end

  def is_operator?
    current_user.operator?
  end

  def after_sign_in_path_for(user)
    admin_path if user.admin? || user.operator?
  end


  def authorize!
    @authorizer = Authorizer.new
    unless @authorizer.permits?(current_user.role, params[:controller], params[:action])
      redirect_to(root_path,
       :notice => "Sorry, you are not authorized to access that page")
    end
  end

end
