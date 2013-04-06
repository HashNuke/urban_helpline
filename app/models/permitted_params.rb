class PermittedParams < Struct.new(:params)

  def service
    params.require(:service).permit(*service_params)
  end

  def event
    params.require(:event).permit(*event_params)
  end

  def category
    params.require(:category).permit(*category_params)
  end

  def user
    attributes = params.require(:user).permit(*user_params)
    if attributes[:password].empty?
      attributes.delete(:password) && attributes.delete(:password_confirmation)
    end
    attributes
  end

  def cart_item
    params.require(:cart_item).permit(*cart_item_params)
  end

  def info_page
    params.require(:info_page).permit(*info_page_params)
  end

  private

  def cart_item_params
    [:cart_id, :document_id, :search_id]
  end

  def user_params
    [:first_name, :last_name, :job_title, :email, :password, :password_confirmation, :role]
  end

  def category_params
    [:name, :slug, :picture, :tag_list]
  end

  def info_page_params
    [:title, :content, :slug]
  end

  def service_params
    [
      :name,
      :picture,
      :description,
      :summary,
      :email,
      :phone,
      :url,
      :tag_list,
      :document_sections_attributes
    ]
  end

  def event_params
    [
      :name,
      :picture,
      :description,
      :summary,
      :email,
      :phone,
      :url,
      :tag_list,
      :document_sections_attributes,
      :address,
      :postal_code,
      :start_date,
      :end_date
    ]
  end
end
