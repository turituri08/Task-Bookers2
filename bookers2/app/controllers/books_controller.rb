class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = current_user
     if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book)
     else
       render :index
     end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    #@books = Book.joins(:favorites).where(favorites: { created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
    #@books = Book.joins(:favorites).where(favorites: { created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
    books_all = Book.all.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day)
    @books = books_all.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @booknew = Book.new
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
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
  end

end
