class ReportsController < ApplicationController

  def coordinator_collections
    @collections = Donation.where(user_id: current_user.id).desc(:created_at)
  end

  def submissions
    @submissions = DonationSubmission.desc(:submission_date)
  end

  def pendings
    user_ids = DonationSubmission.distinct(:user_id)
    @pendings = DonationSubmission.where(:user_id.in => user_ids).desc(:submission_date)
  end

  def coordinator_submissions
    @submissions = DonationSubmission.where(user: current_user).desc(:submission_date)
  end
end
