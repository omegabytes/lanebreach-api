# Lane Breach API
## Development

### Dependencies

* [Docker](https://www.docker.com/)
* [yarn](https://yarnpkg.com/en/) (to provide simple command aliases for lengthy docker commands)

Run `yarn start` at the command line to run the API locally. Be sure you have the Docker agent running.

## Database

The API is currently backed by a [PostgreSQL](https://www.postgresql.org/) database with the [PostGIS extension](https://postgis.net/).

### Data sources

Most of our data comes from [Open Data SF](https://datasf.org/opendata/). See `db/seeds.rb` and
`Dockerfile.db` for further details.

### Local DB

You can connect to the local Postgres instance by running `yarn db` at the command line.

### Production DB

Our production DB is currently hosted on [AWS (RDS)](https://aws.amazon.com/rds/). Use the following command to connect to it:
```
PGPASSWORD=<<PASSWORD>> psql bikelane bikelanes --host bikelanes.cl6adk7d8ywn.us-east-1.rds.amazonaws.com
```

Check your Heroku account to retrieve the password or talk to a maintainer.

## Deployment

The app lives on [Heroku](https://www.heroku.com/) at https://lane-breach.herokuapp.com/ which you must be logged into to deploy. Make sure to add the heroku remote using ```heroku git:remote -a lane-breach```.

You can push a new version of the app by running the following commands:

```
heroku container:push --recursive
heroku container:release web worker
```

You can run migrations using ```heroku run rails db:migrate```.

## Contributing

We welcome contributions! All of our contributors are expected to follow the rules outlined in our Code of Conduct. Please create a separate pull request against master for each new feature/bug-fix. We will try to use Github issues whenever possible to describe tasks that we need to do.

Steps for building the various apps, and an overview of the design can be found on the wiki. We're excited to see your PRs!