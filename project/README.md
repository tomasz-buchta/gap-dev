# DevTest Project

## Usage

Rails defaults

- setup: `bin/setup`
- running: `bin/rails s`
- tests: `bin/rspec`

## Authentication

You need a valid access token from auth0
example query how to get one, I've sent a valid `CLIENT_ID` and `CLIENT_SECRET` in email

The authentication flow is explained here https://auth0.com/docs/flows/concepts/m2m-flow

```
curl --request POST \
  --url https://gap-dev-test.eu.auth0.com/oauth/token \
  --header 'content-type: application/json' \
  --data '{"client_id":"CLIENT_ID","client_secret":"CLIENT_SECRET","audience":"http://lvh.me:3000","grant_type":"client_credentials"}'
```
In response you will get a bearer token which you need to include in AUTHORIZATION header when calling private api endpoints

```
curl --request GET \
  --url http://localhost:3000/api/v1/private \
  --header 'authorization: Bearer YOUR_ACCESS_TOKEN'
```

## Master key

The credentials are encrypted you need to obtain the master key and put it in `config/master.key`, do not commit this file
