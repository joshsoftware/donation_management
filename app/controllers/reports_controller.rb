class ReportsController < ApplicationController

  def collections
    respond_to do |format|
      format.csv{
        send_data Donation.to_csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=donations.csv"
      }
      format.html
        @collections = current_user.is_admin? ? Donation.all.desc(:created_at) : Donation.where(user_id: current_user.id).desc(:created_at)
      end
  end

  def submissions
    @submissions = DonationSubmission.desc(:submission_date)
  end

  def pendings
    @users = User.all
  end

  def coordinator_submissions
    @submissions = DonationSubmission.where(user: current_user).desc(:submission_date)
  end
end
