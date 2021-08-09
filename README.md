# Marvel Site

Test based on Marvel API

## To run at development environment

Create a database.yml file at `config/` based on database.yml.example

This application uses:

- PostgreSQL
- Redis
- Yarn

To install ruby gems

```
bundle install
```

To create the database, run:
```
rake db:create
```

To run the migrations:
```
rake db:migrate
```

You must set some environment variables before running the application or some routines.

Set `MARVEL_PUBLIC_KEY` and `MARVEL_PRIVATE_KEY` values at `.env` or create a `.env.local` file and set the values there.

To run the application you must have `redis` running.

The application also runs some jobs at background. You must have `sidekiq` running too.

Or if you want to run the jobs instantly:

- Run `rake routines:import_comics` to access Marvel API and import comics (or generate some data through `rake db:seed`)
- Run `rake routines:clean_users` to clean expired users


Run `rails s` and access `localhost:3000`

This project uses rspec for tests. To run tests, run the command:

```
rspec spec
```
