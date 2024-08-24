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


=======
## Challenge

Using the Marvel developer API https://developer.marvel.com/, create a simple app that allows the user to scroll through all comics ever released from the most recent to the oldest (and please, let us see the cover picture while at it!). The app should allow users to search by character (eg. deadpool) and allow the user to mark specific comics as favourites.

The assets to recreate the design can be found inside the `assets` folder. The visual page design is to be interpreted as a wireframe - there’s no need to implement a pixel-perfect layout.

The Marvel API interactive documentation can be found here: https://developer.marvel.com/docs

For the purpose of this task, use the following keys:

```
MARVEL_PUBLIC_KEY= ----
MARVEL_PRIVATE_KEY= ----
```

## Requirements

- When I open the page I want to see a list of all Marvel’s released comic books covers ordered from most recent to the oldest
- When I see the list of comics I want to be able to search by character (eg. “deadpool”) so I can find my favorite comics
- When I see the list of comics I want to be able to upvote any of them so that the most popular are easy to find in the future

## Implementation Notes

- Acceptable implementation language is Ruby. You may use any framework readily available to you (using Rails is encouraged!)
- The source code is expected to be versioned on git and a link to a git hosting platform (like GitHub, GitLab, BitBucket) must be provided. The repo can be kept private if you prefer.
- Completed projects must include a README with enough instructions for evaluators to build, test and run the code
- Use appropriate production-capable frameworks
- Use appropriate dependency-management and build tools
- The project's structure and organization should follow best practices
- Prefer immutable design if possible
- Test your code and your API. No need to test every permutation, but demonstrate you know the types of things to test for.
- Even though this is a simplified requirement as appropriate to be an exercise, your code should be production capable
- Assume the application will be used by a reasonable number of users, external API rate limiting may be applied, consider how your solution could help mitigate that.
- User management and authentication (i.e. user sign up, sign in, sign out etc) is not required - feel free to simulate/fake it, e.g. using a cookie-based session.
- If you do want to implement authentication feel free to use any existing library you're familiar with.
- Show your work, if you've used any interesting libraries or approaches during development let us know and explain why in the README

