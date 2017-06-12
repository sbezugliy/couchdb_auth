# couchdb_auth

Apache CouchDB REST API Authorization package for Elixir.

* Supported versions:
  - Elixir: 1.4.2
  - CouchDB: 2.0.0

# Overview

Apache CouchDB REST API client for Elixir.

WIP. No docs, no tests. Will soon.

### Features

* HTTP REST client
* HTTP Authentication:
  * Basic Auth
  * Cookie Auth
  * OAuth

## Installation

Add to mix.exs

```elixir
  def deps do
    [{:couchdb_auth, "~> 0.1.0"}]
  end
```

## Usage

Set required parameters in config/dev.exs, config/prod.exs, config/test.exs

To send authorized request to db server(default port 5984) use next:

CouchDB.client |> CouchDB.get('/\_session')

or to send request to backend server(default port 5984):

CouchDB.client(:backend) |> CouchDB.get("/\_session")

About configuring OAuth, you can read this:

http://www.testenv.top/2017/06/configuring-oauth-10-authentication.html
