class DonationSubmissionsController < ApplicationController
  def new
    @donation = DonationSubmission.new
    @coordinator = User.where(role: 'Coordinator')
  end

  def create
    @donation = DonationSubmission.new(donation_params)
    @donation.received_by = current_user
   if @donation.valid?
    @donation.cumulative_by_cash = @donation.submitted_by_cash.to_i + last_cumulative_by_cash_amounts(@donation.user)
    @donation.cumulative_by_cheque = @donation.submitted_by_cheque.to_i + last_cumulative_by_cheque_amounts(@donation.user)
    @donation.save
    redirect_to new_donation_submission_path
    else
      @coordinator = User.where(role: 'Coordinator')
      render 'new'
    end
  end

  private
  def donation_params
    params.require(:donation_submission).permit(:user_id, :submitted_by_cash, :submitted_by_cheque, :submission_date)
  end

  def last_cumulative_by_cash_amounts(coordinator)
    last_cumulative_amount = coordinator.donation_submissions.desc(:created_at).first.try(:cumulative_by_cash).to_i
  end

  def last_cumulative_by_cheque_amounts(coordinator)
    last_cumulative_amount = coordinator.donation_submissions.desc(:created_at).first.try(:cumulative_by_cheque).to_i
  end

end
