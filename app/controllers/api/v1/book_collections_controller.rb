module Api
  module V1
    class BookCollectionsController < ApplicationController
      def index
        respond_with BookCollection.all, class: serializer
      end

      def show
        respond_with BookCollection.find(params[:id]), class: serializer, include: [:books]
      end

      def create
        respond_with BookCollection.create(book_collection_params), class: serializer
      end

      def update
        book_collection = BookCollection.find(params[:id])
        book_collection.update(book_collection_params)
        respond_with book_collection, class: serializer
      end

      def destroy
        respond_with BookCollection.find(params[:id]).destroy
      end

      private

      def book_collection_params
        deserialized_params.permit(:name)
      end

      def serializer
        SerializableBookCollection
      end
    end
  end
end
