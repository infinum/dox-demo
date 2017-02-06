require 'rails_helper'

RSpec.describe "BookCollections", type: :request do
  describe "GET /book_collections" do
    it "works! (now write some real specs)" do
      get book_collections_path
      expect(response).to have_http_status(200)
    end
  end
end
