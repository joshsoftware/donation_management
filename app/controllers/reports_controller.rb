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
    users = DonationSubmission.users_with_donation_submissions
    user_ids = users.present? ? users.collect(&:id) : [] 
    # Adding pending donations that are not received/submitted
    users = User.with_pending_donations
    # Prepare initial pendings 
    @pendings = users.map(&:donation_submissions).flatten
    @pendings += DonationSubmission.where(:user_id.in => user_ids).desc(:submission_date)
  end

  def coordinator_submissions
    @submissions = DonationSubmission.where(user: current_user).desc(:submission_date)
  end
end
