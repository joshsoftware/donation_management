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
      if @user.update_attributes()
        format.html {redirect_to users_path, notice: "User has been updated successfully"}
      else
        format.html {render action: "edit"}
      end
    end

  end

  def new
  end

  def create
  end
end
