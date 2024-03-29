class PermittedParams < Struct.new(:params)

  def document
    params.require(:document).permit(*document_params)
  end

  def user
    attributes = params.require(:user).permit(*user_params)
    if attributes[:password].empty?
      attributes.delete(:password) && attributes.delete(:password_confirmation)
    end
    attributes
  end

  private


  def user_params
    [:name, :phone, :email, :password, :password_confirmation, :role]
  end

  def document_params
    [
      :name,
      :address,
      :notes,
      :review,
      :phone_numbers_attributes
    ]
  end
end
