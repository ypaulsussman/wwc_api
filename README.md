# What Works Clearinghouse API

I used my [previous Rails toy app](https://github.com/ypaulsussman/opl) to get more familiar with `foreman`, `ActionMailer`, Rails 5.1+ system testing, `webpack`, hand-rolled session-based auth(z/n), and basic full-text search in PostgreSQL.

I'm using this one to learn about [JWT](https://github.com/ypaulsussman/wwc_api/blob/master/app/controllers/tokens_controller.rb), and PostgreSQL's more in-depth full-text search options, before setting it up to feed JSON to (_at least one_) SPA... so I can learn exactly how much I dislike this decoupled approach to app development ^_^

(_In addition, I like what WWC does quite a bit, but I find their their current browser UI opaque and unergonomic to navigate._)

## Setup
- **Option 01:** run `rails db:reset studies=db/WWC-export-archive-2020-Apr-25-142355/Studies.csv findings=db/WWC-export-archive-2020-Apr-25-142355/Findings.csv reports=db/WWC-export-archive-2020-Apr-25-142355/InterventionReports.csv`
  - For newer data, simply substitute the CSV filepaths: modulo any newly-added corruptions to the data, the scrubbers/loaders should function identically.
  - This option is _sloooooooooow_ -- like, ~8-9 minutes slow. It's doing tons of table sequential-scans, and instancing tons of ActiveRecord objects (_neither of which is necessary: but the removal of which is an optimization I haven't yet had time for._)
- **Option 02:** run `rails db:create && rails db:migrate && psql -d wwc_api_development -f ../2020_04_25_data.sql`
  - This requires you to download a public [Gist containing the data](https://gist.github.com/ypaulsussman/ad7cd34f3db8bc4fd410d9b7f6937ed2).
  - You're stuck with the data from April 25th, 2020 (_unless you want to update and PR!_) 😸
  - On the other hand, this method takes under a second.

## Next Steps: Server
- Finish studies searches
  - `rails g controller StudySearches create autocomplete`
  - add method on `Study` model to combine filter params and FTS search into a db query
- Add studies autocomplete
  - add trigrams columns, per https://www.postgresql.org/docs/12/pgtrgm.html#id-1.11.7.40.8 (use the same regexp you did to extract `author_fts`, `title_fts`, and `publication_fts`.)
  - add method on `Study` model (_or elsewhere?_) to select most-similar words from that column

- Add scraper script for FTS `descriptions` field on `interventions` table
  - Use `Intervention_Page_URL`?
- Extract `outcome_domain` to separate Model (_...eventually_)


## Next Steps: Client
- Build `Controller` classes only as needed
- No CSS framework: use FEM notes/O'Reilly books (can possibly reuse across apps)
- Ankify the following, as you reference them:
  - https://csslayout.io/
  - https://htmldom.dev/
  - https://1loc.dev/
  - https://devhints.io/es6
- One API, two SPA's
  - Vue app
    - New framework
    - Still have component classes/lifecycle events
  - React app
    - Familiar framework
    - Only use Hooks and Context API's for state-management
