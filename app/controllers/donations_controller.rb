class DonationsController < ApplicationController
  before_filter :get_collector
  before_filter :check_acceptance_limit

  def new
    @donation = @collector.donations.new
  end

  def create
    @donation = @collector.donations.new(donation_params)
    if @donation.save
      flash[:success] = "Donation made successfully"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def get_collector
    @collector = current_user
  end

  def donation_params
    params.require(:donation).permit!
  end

  def check_acceptance_limit
    collection = @collector.total_collection_by_cash
    if @collector.cash_amount_pending >= @collector.credit_limit
      flash[:warning] = "Good Job! You have exceeded the credit limit, please contact Seva Sahayog office to increase your limit."
      redirect_to collections_reports_path and return
    end
  end
end
