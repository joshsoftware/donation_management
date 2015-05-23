class DonationSubmission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :submitted_by_cash, type: Integer
  field :submitted_by_cheque, type: Integer
  field :cumulative_by_cash, type: Integer
  field :cumulative_by_cheque, type: Integer
  
  belongs_to :user
  belongs_to :received_by, class_name: 'User'
end
