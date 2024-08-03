class ComicsController < ApplicationController
  after_action :save_comics, only: [:index]

  def index
    @marvel_api = MarvelApi.new
    @character_name = params[:character_name]

    begin
      if @character_name.present?
        characters = MarvelApi.new.search_comics_by_character(@character_name)
        characters['data']['results'].each do |character|
          if character['name'] == @character_name
            @character_comics = character['comics']['items']
            break
          else
            flash.now[:alert] = "Character not present on Marve's Api."
          end
        end
      else
        @character_comics = false
        @comics = @marvel_api.fetch_comics
        if @comics.nil? || @comics['data']['results'].empty?
          @comics = { 'data' => { 'results' => [] } }
        end
      end

    rescue => e
      flash.now[:alert] = "An error occurred while fetching comics. Please try again later."
      @comics = { 'data' => { 'results' => [] } }
    end
  end

  def upvote
    @comic = Comic.find_or_create_by(
      marvel_id: params[:id],
      title: params[:title],
      cover_url: params[:cover_url]
    )
    @comic.increment!(:upvotes)

    respond_to do |format|
      format.html { redirect_to comics_path, notice: 'Comic was successfully upvoted.' }
      format.js
    end
  end


  private

  def save_comics
    return if @comics.nil? || @comics['data']['results'].empty?
    @comics['data']['results'].each do |comic_data|
      Comic.find_or_create_by(
        marvel_id: comic_data['id'],
        title: comic_data['title'],
        cover_url: "#{comic_data['thumbnail']['path']}.#{comic_data['thumbnail']['extension']}"
      )
    end
  end
end
