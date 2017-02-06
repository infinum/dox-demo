require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  include ApiDoc::V1::Authors::Api
  let!(:author) { create(:author) }

  let(:valid_attributes) {
    attributes_for(:author)
  }

  let(:invalid_attributes) {
    { name: "" }
  }

  describe "GET #index" do
    include ApiDoc::V1::Authors::Index
    it "returns 200 status" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "returns 200 status" do
      get :show, params: {id: author.id}
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Author" do
        expect {
          post :create, params: {author: valid_attributes}
        }.to change(Author, :count).by(1)
      end

      it "returns 201 status" do
        post :create, params: {author: valid_attributes}
        expect(response).to have_http_status(201)
      end
    end

    context "with invalid params" do
      it "returns 422 status" do
        post :create, params: {author: invalid_attributes}
        expect(response).to have_http_status(422)
      end

      it "doesn't create a new author" do
        expect {
          post :create, params: {author: invalid_attributes}
        }.to_not change(Author, :count)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested author" do
        put :update, params: {id: author.id, author: {name: 'New Author'}}
        expect(author.reload.name).to eq 'New Author'
      end

      it "returns 200 status" do
        put :update, params: {id: author.id, author: valid_attributes}
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "returns 422 status" do
        put :update, params: {id: author.id, author: invalid_attributes}
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested author" do
      expect {
        delete :destroy, params: {id: author.id}
      }.to change(Author, :count).by(-1)
    end

    it "returns 204 status" do
      delete :destroy, params: {id: author.id}
      expect(response).to have_http_status(204)
    end
  end
end
