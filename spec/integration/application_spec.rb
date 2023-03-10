require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_albums_artists_tables
  seed_sql = File.read('spec/seeds/music_library.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do 
    reset_albums_artists_tables
  end

  context "GET /albums" do
    it "returns all albums as a HTML page" do
      response = get("/albums")
    
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Albums</h1>"
      expect(response.body).to include "Doolittle"
      expect(response.body).to include "Surfer Rosa"
      expect(response.body).to include "Super Trouper"
    end
  end

  context "POST /albums" do
    it "creates a new album" do
      response = post("/albums", title: "Voyage", release_year: "2022", artist_id: "2")

      expect(response.status).to eq 200

      response = get("/albums")

      expect(response.body).to include "Voyage"
    end
  end

  context "GET /artists" do
    it "returns all artists" do
      response = get("/artists")

      expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone"

      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
    end
  end

  context "POST /artists" do
    it "creates a new artist" do
      response = post("/artists", name: "Wild nothing", genre: "Indie")

      expect(response.status).to eq 200

      response = get("/artists")

      expect(response.body).to include "Wild nothing"
    end
  end

  context "GET /albums/:id" do
    it "returns HTML content for a single album with the given id" do
      response = get("/albums/1")

      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Doolittle</h1>"
      expect(response.body).to include "Release year: 1989"
      expect(response.body).to include "Artist: Pixies"
    end

    it "returns HTML content for a different album" do
      response = get("/albums/2")

      expect(response.status).to eq 200  
      expect(response.body).to include "<h1>Surfer Rosa</h1>"
      expect(response.body).to include "Release year: 1988"
      expect(response.body).to include "Artist: Pixies"
    end
  end

end
