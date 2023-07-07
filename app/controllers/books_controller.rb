class BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def create
    book = Book.create(title: "Harry potter 1" , author: "JK Bowling")
    if book.save
      render json:book.errors, status: unprocessable_entity
    else
      render
    end
  end
end
