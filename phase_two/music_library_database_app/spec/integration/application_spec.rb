require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  before(:each) do 
    reset_albums_table
    reset_artists_table
  end

  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "outputs a list of all albums HTML formatted" do
      response = get('/albums')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Albums</h1>')
      expect(response.body).to include('<div>')
      expect(response.body).to include('Title: <a href="/albums/1">Doolittle</a>')
      expect(response.body).to include('Released: 1989')
      expect(response.body).to include('Title: <a href="/albums/7">Folklore</a>')
      expect(response.body).to include('Released: 2020')
      expect(response.body).to include('Title: <a href="/albums/12">Ring Ring</a>')
      expect(response.body).to include('Released: 1973')
    end
  end
  
  context 'GET /albums/:id' do
    it 'returns the data of a single album formatted in html' do
      response = get('/albums/1')
      expect(response.status).to eq (200)
      expect(response.body).to include ('<h1>Doolittle</h1>')
      expect(response.body).to include ('Release year: 1989')
      expect(response.body).to include ('Artist: Pixies')      
    end
  end

  context "GET /albums/new" do
    it "returns the form page to add a new album" do
      response = get('/albums/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<form action="/albums" method="POST">')
      expect(response.body).to include("<h1>Add an album</h1>")
      expect(response.body).to include('<input type="text" id="album_title" name="title">')
      expect(response.body).to include('<input type="number" id="release year" name="release_year">')
    end
  end

  context "POST /albums" do
    it "returns a success page" do
      response = post(
        '/albums',
        title: 'Ice, Death, Planets, Lungs, Mushrooms And Lava',
        release_year: '2022'
      )

      expect(response.status).to eq 200
      expect(response.body).to include("<p>Album successfully created</p>")
    end

    it "returns 400" do
      response = post(
        '/albums',
        title: '',
        release_year: ''
      )

      expect(response.status).to eq 400
    end
  end

  context "GET /artists" do
    it "returns 200 OK" do
      response = get('/artists')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Artists</h1>')
      expect(response.body).to include('<div>')
      expect(response.body).to include('Name: <a href="/artists/1">Pixies</a>')
      expect(response.body).to include('Genre: Rock')
      expect(response.body).to include('Name: <a href="/artists/4">Nina Simone</a>')
      expect(response.body).to include('Genre: Pop')
    end
  end

  context "GET /artists/:id" do
    it "returns 200 OK" do
      response = get('/artists/1')

      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Pixies</h1>')
      expect(response.body).to include ('Genre: Rock')  
      expect(response.body).to include ('<a href="/artists">Back</a>')  
    end
  end

  context "GET /artists/new" do
    it "returns a new artist form" do
      response = get('/artists/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<form action="/artists" method="POST">')
      expect(response.body).to include("<h1>Add an artist</h1>")
      expect(response.body).to include('<input type="text" id="name" name="name">')
      expect(response.body).to include('<input type="text" id="genre" name="genre">')
    end
  end

  context "POST /artists" do
    it "returns a success page" do
      response = post(
        '/artists',
        name:'Wild Nothing',
        genre:'Indie'
        )

      expect(response.status).to eq 200
      expect(response.body).to include("<p>Artist successfully added</p>")
    end
    
    it "returns 400" do
      response = post(
        '/artists',
        title: '',
        genre: ''
      )
      
      expect(response.status).to eq 400
    end
  end
end
