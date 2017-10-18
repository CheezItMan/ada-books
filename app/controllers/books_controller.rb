class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]

  def index
    # if genre_id on params is truthy
    if params[:genre_id]
      genre = Genre.find_by(id: params[:genre_id])
      @books = genre.books
    # else there is no given genre_id on params, meaning we're not on a genres path
    else
      @books  = Book.order(:title)
    end
  end

  def show
  end

  def edit
    unless @book
      redirect_to root_path
    end
  end

  def update
    redirect_to books_path unless @book

    if @book.update_attributes book_params
      redirect_to root_path
    else
      render :edit
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = "Book added successfully"
      redirect_to root_path
    else
      flash.now[:error] = "Book not added successfully"
      render :new
    end
  end

  def destroy
    @book.destroy

    redirect_to root_path
  end

  private

  def find_book
    @book = Book.find_by(id: params[:id])
  end

  def book_params
    return params.require(:book).permit(:title, :author_id, :description, :price)
  end

end
