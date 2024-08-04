require 'rails_helper'

RSpec.describe ComicsController, type: :controller do
  describe 'GET #index' do
    before do
      @marvel_api = double('MarvelApi')
      allow(MarvelApi).to receive(:new).and_return(@marvel_api)
      allow(@marvel_api).to receive(:fetch_comics).and_return({ 'data' => { 'results' => [] } })
    end

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @comics' do
      get :index
      expect(assigns(:comics)).to eq({ 'data' => { 'results' => [] } })
    end
  end

  describe 'POST #upvote' do
    let(:comic) { create(:comic) }

    it 'increments the upvotes for the comic' do
      post :upvote, params: { id: comic.marvel_id, title: comic.title, cover_url: comic.cover_url }
      comic.reload
      expect(comic.upvotes).to eq(1)
    end

    it 'redirects to the comics index' do
      post :upvote, params: { id: comic.marvel_id, title: comic.title, cover_url: comic.cover_url }
      expect(response).to redirect_to(comics_path)
    end
  end
end
