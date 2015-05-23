class DonationSubmissionsController < ApplicationController
  def new
    @donation = DonationSubmission.new
    @coordinator = User.where(role: 'Coordinator')
  end

  def create
    @donation = DonationSubmission.new(donation_params)
    @donation.received_by = current_user
    if @donation.save
      redirect_to new_donation_submission_path
    else
      render 'new'
    end
  end

  private
  def donation_params
    params.require(:donation_submission).permit(:submitted_by_cash, :submitted_by_cheque, :submission_date)
  end
end
