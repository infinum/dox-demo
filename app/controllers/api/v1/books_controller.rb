module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: [:show, :update, :destroy]

      # GET /books
      def index
        books = Book.all
        books = books.author(params[:author_id]) if params[:author_id]
        respond_with books, class: SerializableBook
      end

      # GET /books/1
      def show
        respond_with @book, class: SerializableBook
      end

      # POST /books
      def create
        book = Book.new(book_params)
        book.save
        respond_with book, class: SerializableBook
      end

      # PATCH/PUT /books/1
      def update
        @book.update(book_params)
        respond_with @book, class: SerializableBook
      end

      # DELETE /books/1
      def destroy
        @book.destroy
        respond_with 204
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_book
          @book = Book.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def book_params
          params.require(:book).permit(:name, :author_id, :collection_id)
        end
    end
  end
end
