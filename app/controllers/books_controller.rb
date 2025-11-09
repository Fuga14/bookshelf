class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.includes(:author).all
    
    # Search by title
    if params[:search].present?
      @books = @books.where("title ILIKE ?", "%#{params[:search]}%")
    end
    
    # Sort by year or title
    case params[:sort]
    when "year_asc"
      @books = @books.order(year: :asc)
    when "year_desc"
      @books = @books.order(year: :desc)
    when "title_asc"
      @books = @books.order(title: :asc)
    when "title_desc"
      @books = @books.order(title: :desc)
    else
      @books = @books.order(created_at: :desc)
    end
  end

  def show
  end

  def new
    @book = Book.new
    @authors = Author.active.order(:name)
  end

  def edit
    @authors = Author.active.order(:name)
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: "Book was successfully deleted."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author_id, :year, :description, :cover, :cover_data)
  end
end
