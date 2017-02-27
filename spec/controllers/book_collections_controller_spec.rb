require 'rails_helper'

RSpec.describe Api::V1::BookCollectionsController, api: true, type: :controller do
  include ApiDoc::V1::BookCollections::Api
  let!(:book_collection) { create(:book_collection) }
  let(:valid_attributes) { attributes_for(:book_collection) }
  let(:invalid_attributes) { { name: '' } }

  describe 'GET #index' do
    include ApiDoc::V1::BookCollections::Index
    it 'returns book collections', :dox do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    include ApiDoc::V1::BookCollections::Show
    context 'with valid params' do
      it 'returns a book collection', :dox do
        get :show, params: { id: book_collection.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'does not find a book collection', :dox do
        get :show, params: { id: 'invalid_id' }
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST #create' do
    include ApiDoc::V1::BookCollections::Create
    context 'with valid params' do
      it 'creates a new book collection', :dox do
        expect do
          post :create, params: { book_collection: valid_attributes }
        end.to change(BookCollection, :count).by(1)
      end

      it 'returns 201 status' do
        post :create, params: { book_collection: valid_attributes }
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity', :dox do
        post :create, params: { book_collection: invalid_attributes }
        expect(response).to have_http_status(422)
      end

      it "doesn't create a new BookCollection" do
        expect do
          post :create, params: { book_collection: invalid_attributes }
        end.to_not change(BookCollection, :count)
      end
    end
  end

  describe 'PUT #update' do
    include ApiDoc::V1::BookCollections::Update
    context 'with valid params' do
      it 'updates the requested book collection', :dox do
        put :update, params: { id: book_collection.id, book_collection: { name: 'New Book Collection' } }
        expect(book_collection.reload.name).to eq 'New Book Collection'
      end

      it 'returns 200 status' do
        put :update, params: { id: book_collection.id, book_collection: valid_attributes }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity', :dox do
        put :update, params: { id: book_collection.id, book_collection: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    include ApiDoc::V1::BookCollections::Destroy
    it 'deletes the requested book collection', :dox do
      expect do
        delete :destroy, params: { id: book_collection.id }
      end.to change(BookCollection, :count).by(-1)
    end

    it 'returns 204 status' do
      delete :destroy, params: { id: book_collection.id }
      expect(response).to have_http_status(204)
    end
  end
end
