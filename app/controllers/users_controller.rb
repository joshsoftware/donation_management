class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def edit
  end

  def update
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'index'
    else
      render 'new'
    end
  end

  def donation_pending_amounts
    user = User.find(params[:id])
    @cash_pending =  user.cash_amount_pending
    @cheque_pending = user.cheque_amount_pending
  end

  private

  def user_params
    params.require(:user).permit(
      [:email,:password,:password_confirmation,:role,:contact_number,:name,:company_name])
  end
end
