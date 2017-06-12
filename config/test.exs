use Mix.Config

config :couchdb_auth,
  protocol:         "http",        # http or https
  hostname:         "172.17.0.1",  # IP address or hostname
  port:             "5984",        # main API port
  backend_port:     "5986",        # port used in backend transactions, configuring nodes and access to system databases

  database:         "couchdb_test",     # database name

  # Authentication types. Possible: :admin_party, :basic_auth, :cookie_auth, :oauth
  auth_type:        :oauth,

  ### :basic_auth, :cookie_auth
  # Allowed API entry points depends to right of user, used in transactions
  username:         "admin",
  password:         "supersecret",

  ### :oauth
  # OAuth 1.0 credentials
  consumer_key:     "6ab4ddd1ce65f6381cef17e0fbfefd66757440488530275fc085b51edb06f834",
  consumer_secret:  "a723486eaaac5906a834b19881961a36865f43aa560b8d5877ace1d771e6ddd4",
  token:            "f4e4ef1e10be83fa872c24cd52f116671c9da29dc54273caa2b22190d2df9712",
  token_secret:     "d45c84d26c56af1e02ea20e400c4f78e90c3caa1f9600e20199f8418112b9260"
