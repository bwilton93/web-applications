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
end
