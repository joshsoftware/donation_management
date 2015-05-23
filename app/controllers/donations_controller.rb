class DonationsController < ApplicationController
  before_filter :get_collector

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    if @donation.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def get_collector
    #@collector = current_user
  end

  def donation_params
    params.require(:donation).permit!
  end
end
