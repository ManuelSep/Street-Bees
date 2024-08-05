# README

# Comics App

A Ruby on Rails application to browse Marvel comic books using the Marvel API. Users can search comics by character and upvote their favorite comics.

## Requirements

- Ruby 2.7 or later
- Rails 6.1 or later
- Marvel API keys

## Setup

1. **Clone the repository:**
    ```
    git clone https://github.com/yourusername/comics_app.git
    cd comics_app
    ```

2. **Install dependencies:**
    ```
    bundle install
    ```

3. **Set up environment variables:**
    Create a `.env` file in the root of the project and add your Marvel API keys:
    ```
    MARVEL_PUBLIC_KEY=your_public_key
    MARVEL_PRIVATE_KEY=your_private_key
    ```

4. **Set up the database:**
    ```
    rails db:create
    rails db:migrate
    ```

5. **Run the application:**
    ```
    rails server
    ```
    Visit `http://localhost:3000` to see the app in action.

## Usage

- **Browse Comics:** The homepage displays the most recent Marvel comics.
- **Search by Character:** Use the search form to find comics by a specific character.

## Testing

To run the tests, use:
```
bundle exec rspec
```
## Notes

- To deal with external API rate limiting Rack::Attack is used, it limits the request for a specified time.
- To boost performance and have less requests sidekiq or delayed_jobs could be used too.
- For performance the Rails built-in memory_store was implemented.
- User management and authentication was not implemented but it would have been used the devise.


