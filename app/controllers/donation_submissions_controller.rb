class DonationSubmissionsController < ApplicationController
  def new
    @donation = DonationSubmission.new
    @coordinator = User.where(role: 'coordinator')
  end

  def create
    @donation = DonationSubmission.new(donation_params)
    if @donation.save
      redirect_to new_donation_submission_path
    else
      render 'new'
    end
  end

  private
  def donation_params
    params.require(:donation_submission).permit(:cash_amount_pending, :cheque_amount_pending, :amount_collected_by_cash, :amount_collected_by_cheque)
  end
end
