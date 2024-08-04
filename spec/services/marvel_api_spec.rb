# spec/services/marvel_api_spec.rb
require 'rails_helper'

RSpec.describe MarvelApi do
  let(:marvel_api) { MarvelApi.new }

  describe '#fetch_comics' do
    context 'when API returns empty results' do
      before do
        allow(HTTParty).to receive(:get).with(any_args).and_return(double(parsed_response: empty_response, code: 200))
      end

      let(:empty_response) do
        {
          'data' => {
            'results' => []
          }
        }
      end

      it 'returns an empty list of comics' do
        comics = marvel_api.fetch_comics
        expect(comics['data']['results']).to eq([])
      end
    end

    context 'when API returns actual results' do
      before do
        allow(HTTParty).to receive(:get).with(any_args).and_return(double(parsed_response: actual_response, code: 200))
      end

      let(:actual_response) do
        {
          'data' => {
            'results' => [
              { 'id' => 1, 'title' => 'Comic 1', 'thumbnail' => { 'path' => 'http://example.com/image1', 'extension' => 'jpg' } },
              { 'id' => 2, 'title' => 'Comic 2', 'thumbnail' => { 'path' => 'http://example.com/image2', 'extension' => 'jpg' } }
            ]
          }
        }
      end

      it 'returns a list of comics' do
        comics = marvel_api.fetch_comics
        expect(comics['data']['results'].size).to eq(2)
        expect(comics['data']['results'][0]['title']).to eq('Comic 1')
        expect(comics['data']['results'][1]['title']).to eq('Comic 2')
      end
    end
  end

  describe '#search_comics_by_character' do
    context 'when API returns empty results' do
      before do
        allow(HTTParty).to receive(:get).with(any_args).and_return(double(parsed_response: empty_character_response, code: 200))
      end

      let(:empty_character_response) do
        {
          'data' => {
            'results' => []
          }
        }
      end

      it 'returns an empty list of comics for a character' do
        comics = marvel_api.search_comics_by_character('Spider-Man')
        expect(comics['data']['results']).to eq([])
      end
    end

    context 'when API returns actual results' do
      before do
        allow(HTTParty).to receive(:get).with(any_args).and_return(double(parsed_response: actual_character_response, code: 200))
      end

      let(:actual_character_response) do
        {
          'data' => {
            'results' => [
              {
                'id' => 1011334,
                'name' => 'Spider-Man',
                'comics' => {
                  'available' => 2,
                  'items' => [
                    { 'resourceURI' => 'http://gateway.marvel.com/v1/public/comics/21366', 'name' => 'Spider-Man Comic 1' },
                    { 'resourceURI' => 'http://gateway.marvel.com/v1/public/comics/24571', 'name' => 'Spider-Man Comic 2' }
                  ]
                }
              }
            ]
          }
        }
      end

      it 'returns a list of comics for a character' do
        comics = marvel_api.search_comics_by_character('Spider-Man')
        expect(comics['data']['results'][0]['name']).to eq('Spider-Man')
        expect(comics['data']['results'][0]['comics']['items'].size).to eq(2)
        expect(comics['data']['results'][0]['comics']['items'][0]['name']).to eq('Spider-Man Comic 1')
        expect(comics['data']['results'][0]['comics']['items'][1]['name']).to eq('Spider-Man Comic 2')
      end
    end
  end
end
