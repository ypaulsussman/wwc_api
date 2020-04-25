# What Works Clearinghouse API

- Initial Commit:
  - `rails new wwc_api --api --skip-sprockets --skip-action-mailbox --skip-action-text --skip-sprockets --skip-system-test --skip-turbolinks --database=postgresql`
  - Clean up `Gemfile` and `application.rb`
  - Add `Rack::Cors` and `Rack::Attack` middlewares to `initializers/`
- Second Commit:
  - Pull `JsonWebToken`, `User`, `ApplicationController`, `TokensController`, and `Rails.application.routes.draw` code from initial JWT-playground repo
  - Disable JWT-authentication, for now: assume no one cares about this repo enough to actively abuse the API, and that `Rack::Attack` will cover most passive cases
