class DonationSubmission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :submitted_by_cash, type: Integer, default: 0
  field :submitted_by_cheque, type: Integer, default: 0
  field :cumulative_by_cash, type: Integer, default: 0
  field :cumulative_by_cheque, type: Integer, default: 0
  field :submission_date, type: Date

  belongs_to :user
  belongs_to :received_by, class_name: 'User'

  validates :user_id, :submission_date, presence: true

  def self.users_with_donation_submissions
    users = User.where(:id.in => self.distinct(:user_id))
    users.select{|user| user.has_pending_amount? } if users.present?
  end
end
