class ReportsController < ApplicationController

  def coordinator_collections
    @collections = Donation.where(user_id: current_user.id).desc(:created_at)
  end

  def submissions
    @submissions = DonationSubmission.desc(:submission_date)
  end

  def pendings
    user_ids = DonationSubmission.desc(:submission_date).distinct(:user_id)
    @pendings = DonationSubmission.desc(:submission_date).where(used_id: user_ids)
  end

  def coordinator_submissions
    @submissions = DonationSubmission.where(user: current_user).desc(:submission_date)
  end
end
