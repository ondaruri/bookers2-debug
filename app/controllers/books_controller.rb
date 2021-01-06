class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
    @post_comment = PostComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @user = current_user
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
#     ⑱の修正により、エラーメッセージでBody can't be blankが出てくるようになりました。
# つまり、bodyの情報が送れていないor保存できないことが考えられます。
# booksコントローラのストロングパラメータbook_paramsを確認すると、titleのみが許可されている状態です。
# ストロングパラメータは、データベースに保存してもいいものを許可するメソッドですので、bodyを追記してあげる必要があります。
  end

end
