require 'rails_helper'

RSpec.describe Api::V1::BookCollectionsController, type: :controller do
  let!(:book_collection) { create(:book_collection) }

  let(:valid_attributes) {
    attributes_for(:book_collection)
  }

  let(:invalid_attributes) {
    { name: "" }
  }

  describe "GET #index" do
    it "returns 200 status" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "returns 200 status" do
      get :show, params: {id: book_collection.id}
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new BookCollection" do
        expect {
          post :create, params: {book_collection: valid_attributes}
        }.to change(BookCollection, :count).by(1)
      end

      it "returns 201 status" do
        post :create, params: {book_collection: valid_attributes}
        expect(response).to have_http_status(201)
      end
    end

    context "with invalid params" do
      it "returns 422 status" do
        post :create, params: {book_collection: invalid_attributes}
        expect(response).to have_http_status(422)
      end

      it "doesn't create a new BookCollection" do
        expect {
          post :create, params: {book_collection: invalid_attributes}
        }.to_not change(BookCollection, :count)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested BookCollection" do
        put :update, params: {id: book_collection.id, book_collection: {name: 'New Book Collection'}}
        expect(book_collection.reload.name).to eq 'New Book Collection'
      end

      it "returns 200 status" do
        put :update, params: {id: book_collection.id, book_collection: valid_attributes}
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "returns 422 status" do
        put :update, params: {id: book_collection.id, book_collection: invalid_attributes}
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested BookCollection" do
      expect {
        delete :destroy, params: {id: book_collection.id}
      }.to change(BookCollection, :count).by(-1)
    end

    it "returns 204 status" do
      delete :destroy, params: {id: book_collection.id}
      expect(response).to have_http_status(204)
    end
  end
end
