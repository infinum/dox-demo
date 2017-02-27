module Api
  module V1
    class AuthorsController < ApplicationController
      def index
        respond_with Author.all, class: serializer
      end

      def show
        respond_with Author.find(params[:id]), class: serializer, include: [:books]
      end

      def create
        respond_with Author.create(author_params), class: serializer
      end

      def update
        author = Author.find(params[:id])
        author.update(author_params)
        respond_with author, class: serializer
      end

      def destroy
        respond_with Author.find(params[:id]).destroy
      end

      private

      def author_params
        params.require(:author).permit(:name)
      end

      def serializer
        SerializableAuthor
      end
    end
  end
end
