require 'httparty'
require 'digest'

class MarvelApi
  BASE_URL = 'http://gateway.marvel.com/v1/public'.freeze
  API_PUBLIC_KEY = ENV['MARVEL_PUBLIC_KEY']
  API_PRIVATE_KEY = ENV['MARVEL_PRIVATE_KEY']

  def initialize
    @base_url = BASE_URL
  end

  def fetch_comics(offset = 0, limit = 20)
    cache_key = "comics_offset_#{offset}_limit_#{limit}"
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      url = "#{@base_url}/comics?"
      response = with_retries do
        HTTParty.get(url, query: query_params.merge(offset: offset, limit: limit))
      end
      handle_response(response)
    end
  end

  def search_comics_by_character(character_name)
    character_name = character_name if character_name.present?

    cache_key = "character_#{character_name}"
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      url = "#{@base_url}/characters?"
      response = with_retries do
        HTTParty.get(url, query: query_params.merge(name: character_name))
      end
      handle_response(response)
    end
  end

  private

  @ts = Time.now.to_i

  def query_params
    {
      ts: @ts,
      apikey: API_PUBLIC_KEY,
      hash: generate_hash
    }
  end

  def generate_hash
    Digest::MD5.hexdigest("#{@ts}#{API_PRIVATE_KEY}#{API_PUBLIC_KEY}")
  end

  def with_retries
    Retryable.retryable(tries: 3, on: [Net::ReadTimeout, StandardError]) do
      yield
    end
  rescue StandardError => e
    Rails.logger.error("MarvelApi error: #{e.message}")
    raise
  end

  def handle_response(response)
    parsed_response = response.parsed_response
    puts parsed_response.inspect
    if response.code == 200 && parsed_response['data']
      parsed_response
    else
      Rails.logger.error("MarvelApi unexpected response: #{parsed_response}")
      raise "Unexpected response format"
    end
  end
end
