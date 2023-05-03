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

  context "POST /albums with parameters" do
    it 'returns 200 OK' do
      response = post('/albums',title:'Voyage',release_year:2022,artist_id:2)

      expect(response.status).to eq(200)
      expect(response.body).to eq ""

      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('Voyage')
    end
  end

  context "GET /albums" do
    it "outputs a list of all albums HTML formatted" do
      response = get('/albums')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Albums</h1>')
      expect(response.body).to include('<div>')
      expect(response.body).to include('Title: Doolittle')
      expect(response.body).to include('Released: 1989')
      expect(response.body).to include('Title: Folklore')
      expect(response.body).to include('Released: 2020')
      expect(response.body).to include('Title: Ring Ring')
      expect(response.body).to include('Released: 1973')
    end
  end

  context "GET /artists" do
    it "returns 200 OK" do
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to eq('Pixies, ABBA, Taylor Swift, Nina Simone')
    end
  end

  context "POST /artists with parameters" do
    it "returns 200 OK" do
      response = post('/artists',name:'Wild Nothing',genre:'Indie')
      expect(response.status).to eq 200
      expect(response.body).to eq ""

      response = get('/artists')
      expect(response.status).to eq 200
      expect(response.body).to include('Wild Nothing')
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
end
