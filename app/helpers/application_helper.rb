module ApplicationHelper
  def admin_documents_active?(controller_name)
   "active"  if controller_name == "admin/documents"
  end

  def admin_users_active?(controller_name)
    "active" if controller_name == "admin/users"
  end

  def admin_calls_active?(controller_name)
    "active" if controller_name == "admin/calls"
  end
end
