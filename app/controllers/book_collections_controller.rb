class BookCollectionsController < ApplicationController
  before_action :set_book_collection, only: [:show, :update, :destroy]

  # GET /book_collections
  def index
    @book_collections = BookCollection.all

    render json: @book_collections
  end

  # GET /book_collections/1
  def show
    render json: @book_collection
  end

  # POST /book_collections
  def create
    @book_collection = BookCollection.new(book_collection_params)

    if @book_collection.save
      render json: @book_collection, status: :created, location: @book_collection
    else
      render json: @book_collection.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /book_collections/1
  def update
    if @book_collection.update(book_collection_params)
      render json: @book_collection
    else
      render json: @book_collection.errors, status: :unprocessable_entity
    end
  end

  # DELETE /book_collections/1
  def destroy
    @book_collection.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_collection
      @book_collection = BookCollection.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_collection_params
      params.require(:book_collection).permit(:name)
    end
end
