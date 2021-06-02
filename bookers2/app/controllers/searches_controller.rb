class SearchesController < ApplicationController
  def search
    title= params[:range]
    search = params[:word]
    @output = "#{title} search for \"#{search}\""
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    elsif @range == "Book"
      @books = Book.looks(params[:search], params[:word])
    end
  end
end
