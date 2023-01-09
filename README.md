``docker-compose` is required to run the server component.

## Running the server

Create a `.env` file in the root directory of the project with the following contents:

To run the server, run the following command:

```bash
# docker-compose up
```

If you're running the server for the first time, you'll need to run the following command to create the database:

```bash
# docker-compose run db sh -c "cat /commands/*.sql | psql -U $POSTGRES_USER -d $POSTGRES_DB"
```
