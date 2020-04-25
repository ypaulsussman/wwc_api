# frozen_string_literal: true

# Rails uses this file for your schema during `rails db:schema:load`

# rubocop:disable Style/NumericLiterals
ActiveRecord::Schema.define(version: 2020_04_24_025213) do
  enable_extension 'plpgsql'

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end
end
# rubocop:enable Style/NumericLiterals
