# Photoverse

Simple Instagram clone made for hobby.

## Requirements

- Ruby 3.0.0
- Rails 7.0.2.3
- SQLite3
- [libvips](https://www.libvips.org)

## Getting started

To get the Rails server running locally:

- Clone this repo
- `bundle install` to install required dependencies for Rails
- `yarn` to install required dependencies for Node
- `rails db:setup` to create the database initialized with seed data
- `./bin/dev` to start the local rails server with tailwindcss compiler

## Code Layout / Styling Check

- run `rubocop --auto-correct` to use Rubocop gem to automatically fix style validations in the code
- run `erblint --lint-all --autocorrect` to use Erb-lint gem to lint all erb files and fix validations automatically
