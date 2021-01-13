class Api::BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    render json: Book.all
  end

  def show
    render json: @book
  end
  
  def create
    book = Book.new(book_params)

    if book.save
      render json: book , status: :created
    else
      render json: {}
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: {}
    end
  end

  def destroy
    @book.destroy
    render json: {} , status: :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def book_params
    params.require(:book).permit(:title, :summary)
  end
end
