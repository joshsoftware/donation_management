class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html {redirect_to users_path, notice: "User has been updated successfully"}
      else
        format.html {render action: "edit"}
      end
    end
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

  private

  def user_params
    params.require(:user).permit(
      [:email,:password,:password_confirmation,:role,:contact_number,:name,:company_name, :credit_limit])
  end

  def donation_pending_amounts
    user = User.find(params[:id])
    @cash_pending =  user.cash_amount_pending
    @cheque_pending = user.cheque_amount_pending
  end

end
