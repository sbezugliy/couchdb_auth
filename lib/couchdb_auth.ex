defmodule CouchDB do
  use Tesla

  import CouchDB.Environment
  #import CouchDB.HTTP
  plug Tesla.Middleware.BaseUrl, base_url()
  plug Tesla.Middleware.Headers, %{"User-Agent" => "tesla"}
  #plug Tesla.Middleware.JSON
  plug Tesla.Middleware.DecodeJson
  plug Tesla.Middleware.EncodeJson

  adapter Tesla.Adapter.Hackney

  def client(interface \\ :base, opts \\ %{}) do

    url = case interface do
            :backend  -> backend_url()
            _         -> base_url()
          end

    opts =  Map.merge(%{
              username: server_admin()[:user],
              password: server_admin()[:password],
              url: url},
              opts)
    IO.inspect opts
    case auth_type() do
      :basic ->
        Tesla.build_client [{Tesla.Middleware.CouchDB.BasicAuth, opts}]
      :cookie ->
        Tesla.build_client [{Tesla.Middleware.CouchDB.CookieAuth, opts}]
      :oauth ->
        Tesla.build_client [{Tesla.Middleware.CouchDB.OAuth, Map.merge(oauth_creds(), %{url: url})}]
      _ ->
        {}
    end
  end
end
