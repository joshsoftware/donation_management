class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :role, type: String
  field :contact_number, type: String
  field :name, type: String
  field :company_name, type: String
  field :credit_limit, type: Integer
  field :total_collection_by_cash, type: Integer
  field :total_collection_by_check, type: Integer

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

   validates :role, presence: true, :inclusion => { :in => ['Super Admin', 'Admin', 'Coordinator'] }

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  #Validations
  validates :role, :contact_number, presence: true
  has_many :donations
  has_many :donation_submissions, inverse_of: :user

  def cash_amount_pending
    total_submitted = self.donation_submissions.desc(:created_at).first.try(:cumulative_by_cash).to_i
    amount_pending = self.total_collection_by_cash - total_submitted
  end

  def cheque_amount_pending
    total_submitted = self.donation_submissions.desc(:created_at).first.try(:cumulative_by_cheque).to_i
    amount_pending = self.total_collection_by_check - total_submitted
  end

end
