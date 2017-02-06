require "rails_helper"

RSpec.describe BookCollectionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/book_collections").to route_to("book_collections#index")
    end

    it "routes to #new" do
      expect(:get => "/book_collections/new").to route_to("book_collections#new")
    end

    it "routes to #show" do
      expect(:get => "/book_collections/1").to route_to("book_collections#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/book_collections/1/edit").to route_to("book_collections#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/book_collections").to route_to("book_collections#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/book_collections/1").to route_to("book_collections#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/book_collections/1").to route_to("book_collections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/book_collections/1").to route_to("book_collections#destroy", :id => "1")
    end

  end
end
