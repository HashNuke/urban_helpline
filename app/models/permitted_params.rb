class PermittedParams < Struct.new(:params)

  def user
    attributes = params.require(:user).permit(*user_params)
    if attributes[:password].empty?
      attributes.delete(:password) && attributes.delete(:password_confirmation)
    end
    attributes
  end

  private


  def user_params
    [:first_name, :last_name, :job_title, :email, :password, :password_confirmation, :role]
  end
end
