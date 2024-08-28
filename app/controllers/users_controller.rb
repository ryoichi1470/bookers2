class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
    flash[:notice] = "You have signed up successfully"
    redirect_to user_path(@user)
    else
    render :new
    end 
  end
  
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user== current_user.id
    redirect_to user_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    unless @user == current_user.id
    redirect_to user_path
    end
    if @user.update(user_params)
      flash[:notice] = "Updated successfully"
      redirect_to @user
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end 
end
