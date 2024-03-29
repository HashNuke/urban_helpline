class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :name,               :type => String, :default => ""
  field :role,               :type => String, :default => "operator"
  field :encrypted_password, :type => String, :default => ""

  field :phone,              :type => String, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  field :authentication_token, :type => String

  #NOTE possible values
  #     away: not subscribed to handle calls
  #     available / busy: subscribed to handle calls
  field :call_handler_status, :type => String, default: "away"

  before_save :ensure_authentication_token

  has_many :phone_calls, dependent: :nullify

  def self.roles
    ["operator", "admin"]
  end

  def operator?
    self.role == "operator"
  end

  def admin?
    self.role == "admin"
  end
end
