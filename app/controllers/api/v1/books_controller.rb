module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = params[:author_id].present? ? books.authored_by(params[:author_id]) : Book.all
        respond_with books, class: serializer
      end

      def show
        respond_with Book.find(params[:id]), class: serializer, include: [:author, :book_collection]
      end

      def create
        respond_with Book.create(book_params), class: serializer
      end

      def update
        book = Book.find(params[:id])
        book.update(book_params)
        respond_with book, class: serializer
      end

      def destroy
        respond_with Book.find(params[:id]).destroy
      end

      private

      def book_params
        deserialized_params.permit(:name, :author_id, :collection_id)
      end

      def serializer
        SerializableBook
      end
    end
  end
end
