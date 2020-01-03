# frozen_string_literal: true

RSpec.describe Api::V1::BooksController, api: true, type: :controller do
  include ApiDoc::V1::Books::Api
  let(:author) { create(:author) }
  let!(:book) { create(:book, author: author) }

  let(:valid_attributes) { { name: 'New Book', author_id: author.id } }
  let(:invalid_attributes) { { name: '' } }

  describe 'GET #index' do
    include ApiDoc::V1::Books::Index
    it 'returns books', :dox do
      create_list(:book, 2)

      get :index, headers: { 'X-Key' => '123456' }

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('api/v1/books')
    end
  end

  describe 'GET #show' do
    include ApiDoc::V1::Books::Show
    context 'valid params' do
      it 'returns a book', :dox do
        get :show, params: { id: book.id, author_id: author.id }
        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('api/v1/book')
      end
    end

    context 'invalid params' do
      it 'does not return a book', :dox do
        get :show, params: { id: 'invalid_id' }
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST #create' do
    include ApiDoc::V1::Books::Create
    context 'with valid params' do
      it 'creates a new book', :dox do
        expect do
          post :create, body: jsonapi_body(nil, :book, valid_attributes)
        end.to change(Book, :count).by(1)
      end

      it 'returns 201 status' do
        post :create, body: jsonapi_body(nil, :book, valid_attributes)
        expect(response).to have_http_status(201)
        expect(response).to match_response_schema('api/v1/book')
      end
    end

    context 'with invalid params', :dox do
      it 'returns unprocessable entity' do
        post :create, body: jsonapi_body(nil, :book, invalid_attributes)
        expect(response).to have_http_status(422)
      end

      it "doesn't create a new book" do
        expect do
          post :create, body: jsonapi_body(nil, :book, invalid_attributes)
        end.to_not change(Book, :count)
      end
    end
  end

  describe 'PUT #update' do
    include ApiDoc::V1::Books::Update
    context 'with valid params' do
      it 'updates the requested book', :dox do
        put :update, params: { id: book.id }, body: jsonapi_body(book.id, :book, name: 'New Book')
        expect(book.reload.name).to eq 'New Book'
      end

      it 'returns 200 status' do
        put :update, params: { id: book }, body: jsonapi_body(book.id, :book, name: 'New Book')
        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('api/v1/book')
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity', :dox do
        put :update, params: { id: book }, body: jsonapi_body(book.id, :book, name: '')
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    include ApiDoc::V1::Books::Destroy
    it 'deletes the requested book', :dox do
      expect { delete :destroy, params: { id: book.id } }.to change(Book, :count).by(-1)
    end

    it 'returns 204 status' do
      delete :destroy, id: book.id
      expect(response).to have_http_status(204)
    end
  end
end
