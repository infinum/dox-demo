require 'rails_helper'

RSpec.describe Api::V1::AuthorsController, api: true, type: :controller do
  include ApiDoc::V1::Authors::Api
  let!(:author) { create(:author) }
  let(:valid_attributes) { json_api_attrs_for(:author) }
  let(:invalid_attributes) { json_api_attrs_for(:author, name: '') }

  describe 'GET #index' do
    include ApiDoc::V1::Authors::Index

    it 'returns a list of authors', :dox do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    include ApiDoc::V1::Authors::Show
    context 'valid params' do
      it 'returns an author', :dox do
        get :show, params: { id: author.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'invalid params' do
      it 'does not find an author', :dox do
        get :show, params: { id: 'invalid_id' }
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST #create' do
    include ApiDoc::V1::Authors::Create
    context 'with valid params' do
      it 'creates a new Author', :dox do
        expect { post :create, params: valid_attributes }.to change(Author, :count).by(1)
      end

      it 'returns 201 status' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity', :dox do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(422)
      end

      it "doesn't create a new author" do
        expect { post :create, params: invalid_attributes }.to_not change(Author, :count)
      end
    end
  end

  describe 'PUT #update' do
    include ApiDoc::V1::Authors::Update
    context 'with valid params' do
      it 'updates the requested author', :dox do
        put :update, params: update_params_for(author, name: 'New Author')
        expect(author.reload.name).to eq 'New Author'
      end

      it 'returns 200 status' do
        put :update, params: update_params_for(author, name: 'New Author')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity', :dox do
        put :update, params: update_params_for(author, name: '')
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    include ApiDoc::V1::Authors::Destroy
    it 'deletes the requested author', :dox do
      expect { delete :destroy, params: { id: author.id } }.to change(Author, :count).by(-1)
    end

    it 'returns 204 status' do
      delete :destroy, params: { id: author.id }
      expect(response).to have_http_status(204)
    end
  end
end
