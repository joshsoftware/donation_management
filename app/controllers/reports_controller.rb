class ReportsController < ApplicationController

  def collections
  end

  def submissions
    @submissions = DonationSubmission.desc(:submission_date)
  end

  def pendings
    user_ids = DonationSubmission.desc(:submission_date).distinct(:user_id)
    @pendings = DonationSubmission.desc(:submission_date).where(used_id: user_ids)
  end
end
