class ComicsController < ApplicationController
  def index
    @marvel_api = MarvelApi.new
    # test
    @character_name = params[:character_name]
    # test fim

    begin
      # if params[:character_name].present?
      #   @character_name = params[:character_name]
      #   characters = MarvelApi.new.search_comics_by_character(@character_name)
      #   characters['data']['results'].each do |character|
      #     if character['name'] == @character_name
      #       return @character_comics = character['comics']['items']
      #     else
      #       flash.now[:alert] = "Character not present on Marve's Api."
      #     end
      #   end
      # else
      #   @character_comics = false
      #   @comics = @marvel_api.fetch_comics
      #   if @comics.nil? || @comics['data']['results'].empty?
      #     flash.now[:alert] = "No comics available at the moment."
      #     @comics = { 'data' => { 'results' => [] } }
      #   end
      # end

        # test
        if @character_name.present?
          @comics = search_comics_by_character(character_name)
          if @comics.nil? || @comics['data']['results'].empty?
            flash.now[:alert] = "No comics found for the specified character."
            @comics = { 'data' => { 'results' => [] } }
          end
        else
          @character_name = false
          @comics = @marvel_api.fetch_comics
          if @comics.nil? || @comics['data']['results'].empty?
            flash.now[:alert] = "No comics available at the moment."
            @comics = { 'data' => { 'results' => [] } }
          end
        end

       # Save fetched comics to the database
        @comics['data']['results'].each do |comic_data|
          Comic.find_or_create_by(
            marvel_id: comic_data['id'],
            title: comic_data['title'],
            cover_url: "#{comic_data['thumbnail']['path']}.#{comic_data['thumbnail']['extension']}"
          )
        end
        # test  fim
    rescue => e
      flash.now[:alert] = "An error occurred while fetching comics. Please try again later."
      @comics = { 'data' => { 'results' => [] } }
    end
  end

  def upvote
    # @comic = Comic.find(params[:id])
    # test
    @comic = Comic.find_or_create_by(
      marvel_id: params[:id],
      title: params[:title],
      cover_url: params[:cover_url]
    )
    # test fim
    @comic.increment!(:upvotes)
    redirect_to comics_path, notice: "Upvoted successfully!"
  end

  # test
  private

  def search_comics_by_character(character_name)
    character_data = @marvel_api.search_comics_by_character(character_name)
    character = character_data['data']['results'].find { |c| c['name'].downcase == character_name.downcase }

    if character
      character_comics = character['comics']['items']
      character_comics.map do |comic|
        comic_id = comic['resourceURI'].split('/').last
        @marvel_api.fetch_comic_by_id(comic_id)
      end.flatten
    else
      { 'data' => { 'results' => [] } }
    end
  end
  # test fim
end
