require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context 'POST /sort-names' do
    it 'returns 200 ok' do
      response = post('/sort-names?names=Joe,Alice,Zoe,Julia,Kieran')

      expect(response.status).to eq 200
      expect(response.body).to eq 'Alice,Joe,Julia,Kieran,Zoe'
    end
  end

  context 'GET to /hello' do
    it 'returns 200 OK' do
      response = get('/hello')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Hello!</h1>')
    end
  end
end
