require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
 

  context 'GET /albums/:id' do
    it 'delivers html code with album details' do
      response = get('/albums/2')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')  
    end
  end
   
  # context 'POST /artists' do
  #   it 'should add an artist to db' do
  #     response = post('/artists',
  #       name: 'Wild Nothing',
  #       genre: 'Indie')

  #     expect(response.status).to eq(200)
  #     expect(response.body).to eq('')
      
  #     response = get('/artists')
  #     expect(response.body).to include('Wild Nothing')
      
  #   end
  # end
  context 'GET /albums' do
    it 'returns an HTML formatted list of albums' do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('Title: Surfer Rosa')
      expect(response.body).to include('<a href="/albums/2">') 
    end
  end
  context 'GET /artist/id' do
    it 'returns HTML page with single artist details' do
      response = get('/artist/2')
      expect(response.status).to eq(200)
      expect(response.body).to include('ABBA')
    end
  end
  context 'GET /artists' do
    it 'returns a list of artists with links to their page' do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include('Genre: Pop')
      expect(response.body).to include('<a href="/artist/2">') 
    end
  end
  context 'Get /albums/new' do
    it 'returns a form for adding an album' do
      response = get('/albums/new') 

      expect(response.status).to eq(200)
      expect(response.body).to include('Album')
    end
  end
  context 'POST /albums' do
    it 'should create a new album and return a response page' do
      response = post('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('New album added to library')
    end
  end
  context 'Get /artists/new' do
    it 'returns a form for adding an artist' do
      response = get('/artists/new') 

      expect(response.status).to eq(200)
      expect(response.body).to include('Artist')
    end
  end
  context 'POST /artists' do 
    it 'should add a new artist when form is submitted' do
      response = post('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include('New artist added to library')
    end
  end
end