# README

## Tic Tac Toe Game - Rails Application

This document provides the necessary steps to set up and run the Tic Tac Toe game Rails application and its accompanying test suite.

### Prerequisites

Before you begin, ensure you have the following installed:

- Ruby (version as specified in `.ruby-version`)
- Rails (version as specified in `Gemfile`)
- Bundler
- SQLite3 or any other database your app requires

### Setup

1. **Clone the repository:**

   ```bash
   git clone <REPOSITORY_URL>
   cd <REPOSITORY_DIRECTORY>
   ```

2. **Install dependencies:**

   Navigate to the project directory and install the Ruby and Node.js dependencies:

   ```bash
   bundle install
   ```

3. **Database setup:**

   ```bash
   rails db:migrate
   ```

4. **Start the Rails server:**

   ```bash
   rails server
   ```

5. **Running Tests with RSpec:**

   ```bash
    bundle exec rspec
   ```
