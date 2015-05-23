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

  validates_presence_of :user
end
