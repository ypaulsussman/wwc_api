# What Works Clearinghouse API

- Initial Commit:
  - `rails new wwc_api --api --skip-sprockets --skip-action-mailbox --skip-action-text --skip-sprockets --skip-system-test --skip-turbolinks --database=postgresql`
  - Clean up `Gemfile` and `application.rb`
  - Add `Rack::Cors` and `Rack::Attack` middlewares to `initializers/`
