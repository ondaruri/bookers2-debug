class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @book_id = Book.find(params[:id])
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
    @books = @user.books
  end

  def edit
    @user = current_user
    if params[:id].to_i == current_user.id
      render :edit
    else
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    @books = @user.books
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

    def follows
      @user = User.find(params[:id])
      @users = @user.follower
    end

    def follower
      @user = User.find(params[:id])
    end

# redirect_to users_path(@user), notice: "You have updated user successfully."
# users.1は余分に引数を渡しているときにこのように表示されます。
# users_pathはindexページですのでid(引数)は不要ですが、(@user)が渡されてしまっています。
# 今回は見本のBookers通りに詳細ページにリダイレクトしたいため、user_path(@user)が適切です。

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
