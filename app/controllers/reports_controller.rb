class ReportsController < ApplicationController

  def collections
  end

  def submissions
    @submissions = DonationSubmission.desc(:submission_date)
  end

  def pendings
    user_ids = DonationSubmission.distinct(:user_id)
    @pendings = DonationSubmission.where(:user_id.in => user_ids).desc(:submission_date)
  end
end
