class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :invitable, :database_authenticatable,
    :recoverable, :rememberable, :trackable, :validatable#, :registerable

  Roles = ['Super Admin', 'Admin', 'Coordinator']
  
  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :role, type: String
  field :contact_number, type: String
  field :name, type: String
  field :company_name, type: String
  field :credit_limit, type: Integer, default: 25000
  field :total_collection_by_cash, type: Integer, default: 0
  field :total_collection_by_cheque, type: Integer, default: 0

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  #inviatable
  field :invitation_token, type: String
  field :invitation_created_at, type: Time
  field :invitation_sent_at, type: Time
  field :invitation_accepted_at, type: Time
  field :invitation_limit, type: Integer

  index( {invitation_token: 1}, {:background => true} )
  index( {invitation_by_id: 1}, {:background => true} )

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  #Validations
  validates :contact_number, presence: true
  validates :role, presence: true, :inclusion => { :in => Roles }
  has_many :donations
  has_many :donation_submissions, inverse_of: :user

  def cash_amount_pending
    total_submitted = self.donation_submissions.desc(:created_at).first.try(:cumulative_by_cash).to_i
    return self.total_collection_by_cash if total_submitted == 0
    amount_pending = self.total_collection_by_cash - total_submitted
  end

  def cheque_amount_pending
    total_submitted = self.donation_submissions.desc(:created_at).first.try(:cumulative_by_cheque).to_i
    return self.total_collection_by_cheque if total_submitted == 0
    amount_pending = self.total_collection_by_cheque - total_submitted
  end

  def is_admin?
    ['Super Admin', 'Admin']. include? role
  end

  def is_super_admin?
    role == Roles[0]
  end

  def display_name
    name.nil? ? email : name
  end

  def self.with_pending_donations
    users = all.select{|user| user.donation_submissions.blank? and user.donations.present? }.uniq
    users.map(&:build_pending_donations) if users.present?
    users
  end

  def build_pending_donations
    self.donation_submissions.build(submission_date: self.donations.desc(:created_at).first.created_at)
  end

  def has_pending_amount?
    self.cash_amount_pending != 0 or self.cheque_amount_pending != 0
  end
end
