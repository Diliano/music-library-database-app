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
      expect(response.body).to include "<a href=\"/albums/1\">Go to album page</a>"
      expect(response.body).to include "<a href=\"/albums/2\">Go to album page</a>"
      expect(response.body).to include "<a href=\"/albums/4\">Go to album page</a>"
    end
  end

  context "POST /albums" do
    it "creates a new album and returns a HTML success page" do
      response = post("/albums", title: "Voyage", release_year: "2022", artist_id: "2")

      expect(response.status).to eq 200
      expect(response.body).to include "<p>Album has been added</p>"

      response = get("/albums")

      expect(response.body).to include "Voyage"
    end
  end

  context "GET /artists" do
    it "returns all artists" do
      response = get("/artists")

      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Artists</h1>"
      expect(response.body).to include "Pixies"
      expect(response.body).to include "ABBA"
      expect(response.body).to include "<a href=\"/artists/1\">Go to artist page</a>"
      expect(response.body).to include "<a href=\"/artists/2\">Go to artist page</a>"
    end
  end

  context "POST /artists" do
    it "creates a new artist and returns a HTML success page" do
      response = post("/artists", name: "Wild nothing", genre: "Indie")

      expect(response.status).to eq 200
      expect(response.body).to include "<p>Artist has been added</p>"

      response = get("/artists")

      expect(response.body).to include "Wild nothing"
    end
  end

  context "GET /albums/:id" do
    it "returns HTML content for a single album with a given id" do
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

  context "GET /artists/:id" do 
    it "returns HTML content for a single artist with a given id" do
      response = get("/artists/1")

      expect(response.status).to eq 200 
      expect(response.body).to include "<h1>Pixies</h1>"
      expect(response.body).to include "Rock"
    end

    it "returns HTML content for a different artist" do
      response = get("/artists/2")

      expect(response.status).to eq 200 
      expect(response.body).to include "<h1>ABBA</h1>"
      expect(response.body).to include "Pop"
    end
  end

  context "GET /albums/new" do
    it "returns the HTML form page to create a new album" do
      response = get("/albums/new")

      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Add a new album</h1>"
      expect(response.body).to include "<form action=\"/albums\" method=\"POST\">"
      expect(response.body).to include "<input type=\"text\" name=\"title\">"
    end
  end

  context "GET /artists/new" do
    it "returns the HTML form page to create a new album" do
      response = get("/artists/new")

      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Add a new artist</h1>"
      expect(response.body).to include '<form action="/artists" method="POST"'
      expect(response.body).to include '<input type="text" name="name'
    end
  end

end
