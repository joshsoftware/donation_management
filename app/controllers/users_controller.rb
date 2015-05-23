class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  def donation_pending_amounts
    user = User.find(params[:id])
    @cash_pending =  user.cash_amount_pending
    @cheque_pending = user.cheque_amount_pending
  end

end
