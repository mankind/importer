class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :update,  :destroy]
  
  def index
    @attachments = Current.user.attachments
    @books = Current.user.books

    @last_upload = Current.user.books_from_last_csv

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
  
    respond_to do |format|
      if @book.save
     
        format.html {redirect_to @book, notice: 'Book was successful created'}
        
        format.html {redirect_to root_path, notice: 'Book was successful created'}

        format.json {render :show, status: :created, location: @book}
        format.js
      else
        format.html {render :new}
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end

    end

  end


  private

  def book_params
    params.require(:book).permit(:title, :author, :date, :uuid, :publisher_name, :user_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end


end
