class BooksController < ApplicationController

  def new
    @book = Book.new
    @user = User.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = current_user
     if @book.save
       redirect_to book_path(current_user)
     else
       render :new
     end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
