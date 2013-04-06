class Authorizer

  class << self
    attr_accessor :permissions
  end


  def self.setup_permissions
    @permissions = {}

    [:operator, :admin].each do |role|
      allow role, "admin", only: [:index]
    end

    allow :operator, "admin/calls", only: [:handle]

    [:admin].each do |role|
      allow role, "admin/documents"
      allow role, "admin/users"
      allow role, "admin/calls"
    end
  end


  def self.allow(role, controller, options=:all)
    @permissions[role.to_sym] ||= {}
    @permissions[role.to_sym][controller] = options
  end


  def permissions
    self.class.permissions
  end


  def permits?(role, controller, action=nil)
    role = role.to_sym
    return false if !permissions[role].try(:[], controller)
    return true  if  permissions[role][controller] == :all

    return false if action.nil?

    return true if  permissions[role][controller].try(:[],:only).try(:include?, action)
    return true if !permissions[role][controller].try(:[],:except).try(:include?, action)
  end

  setup_permissions
end
