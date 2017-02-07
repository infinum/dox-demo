module Api
  module V1
    class AuthorsController < ApplicationController
      before_action :set_author, only: [:show, :update, :destroy]

      # GET /authors
      def index
        authors = Author.all
        respond_with authors, class: SerializableAuthor
      end

      # GET /authors/1
      def show
        respond_with @author, class: SerializableAuthor, include: [:books]
      end

      # POST /authors
      def create
        author = Author.new(author_params)
        author.save
        respond_with author, class: SerializableAuthor
      end

      # PATCH/PUT /authors/1
      def update
        @author.update(author_params)
        respond_with @author, class: SerializableAuthor
      end

      # DELETE /authors/1
      def destroy
        @author.destroy
        respond_with 204
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_author
          @author = Author.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def author_params
          params.require(:author).permit(:name)
        end
    end
  end
end
