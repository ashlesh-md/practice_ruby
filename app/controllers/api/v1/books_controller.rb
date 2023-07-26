module Api
  module V1
    class BooksController < ApplicationController
      
      def index
        books = Book.limit(params[:limit]).offset(params[:offset])
        render json: BookRepresenter.new(books).as_json
      end

      def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))
        if book.save
          render json: BookRepresenter.new([book]).as_json.first, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def show
        book = Book.find(params[:id])
        render json: BookRepresenter.new([book]).as_json.first , status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Book not found' }, status: :not_found
      end

      def destroy
        if book = Book.find(params[:id])
          book.destroy!
          render json: book
        else
        render json: { error: 'Book not found' }, status: :not_found
        end
      end

      private

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def book_params
        params.require(:book).permit(:title)
      end

    end
  end
end
