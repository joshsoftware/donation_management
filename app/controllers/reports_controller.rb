class ReportsController < ApplicationController

  def collections
  end

  def submissions
    if params[:type] == 'collected'
      @submissions = DonationSubmission.desc(:submission_date)
    elsif params[:type] == 'pending'
      @submissions = DonationSubmission.desc(:submission_date)
    end
    render params[:type]
  end
end
