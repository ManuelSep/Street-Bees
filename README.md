# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Comics App

A simple Ruby on Rails application to browse Marvel comic books using the Marvel API. Users can search comics by character and mark their favorite comics.

## Requirements

- Ruby 2.7 or later
- Rails 6.1 or later
- Marvel API keys

## Setup

1. **Clone the repository:**
    ```sh
    git clone https://github.com/yourusername/comics_app.git
    cd comics_app
    ```

2. **Install dependencies:**
    ```sh
    bundle install
    ```

3. **Set up environment variables:**
    Create a `.env` file in the root of the project and add your Marvel API keys:
    ```sh
    MARVEL_PUBLIC_KEY=your_public_key
    MARVEL_PRIVATE_KEY=your_private_key
    ```

4. **Set up the database:**
    ```sh
    rails db:create
    rails db:migrate
    ```

5. **Run the application:**
    ```sh
    rails server
    ```
    Visit `http://localhost:3000` to see the app in action.

## Usage

- **Browse Comics:** The homepage displays the most recent Marvel comics.
- **Search by Character:** Use the search form to find comics by a specific character.
- **Favorite Comics:** Click the "Favorite" button to mark a comic as a favorite. View your favorites on the homepage.

## Testing

To run the tests, use:
```sh
bundle exec rspec
