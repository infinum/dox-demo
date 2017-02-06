require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  # include ApiDoc::V1::Books
  let(:author) { create(:author) }
  let!(:book) { create(:book, author: author) }

  let(:valid_attributes) {
    { name: 'New Book', author_id: author.id }
  }

  let(:invalid_attributes) {
     { name: '' }
  }

  describe "GET #index" do
    it "returns 200 status" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "returns 200 status" do
      get :show, params: {id: book.id}
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, params: {book: valid_attributes}
        }.to change(Book, :count).by(1)
      end

      it "returns 201 status" do
        post :create, params: {book: valid_attributes}
        expect(response).to have_http_status(201)
      end
    end

    context "with invalid params" do
      it "returns 422 status" do
        post :create, params: {book: invalid_attributes}
        expect(response).to have_http_status(422)
      end

      it "doesn't create a new book" do
        expect {
          post :create, params: {book: invalid_attributes}
        }.to_not change(Book, :count)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested book" do
        put :update, params: {id: book.id, book: {name: 'New Book'}}
        expect(book.reload.name).to eq 'New Book'
      end

      it "returns 200 status" do
        put :update, params: {id: book.id, book: valid_attributes}
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "returns 422 status" do
        put :update, params: {id: book.id, book: invalid_attributes}
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested book" do
      expect {
        delete :destroy, params: {id: book.id}
      }.to change(Book, :count).by(-1)
    end

    it "returns 204 status" do
      delete :destroy, params: {id: book.id}
      expect(response).to have_http_status(204)
    end
  end

end
