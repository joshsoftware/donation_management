class ReportsController < ApplicationController

  def collections
  end

  def submissions
    @submission = DonationSubmission.desc(:submission_date).first
  end
end
