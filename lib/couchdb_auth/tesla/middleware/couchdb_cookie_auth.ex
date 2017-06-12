defmodule Tesla.Middleware.CouchDB.CookieAuth do
  @moduledoc """
  Basic authentication middleware

  [Wiki on the topic](https://en.wikipedia.org/wiki/Basic_access_authentication)

  Example:
      defmodule MyClient do
        use Tesla

        def client(username, password, opts \\ %{}) do
          Tesla.build_client [
            {Tesla.Middleware.BasicAuth, Map.merge(%{username: username, password: password}, opts)}
          ]
        end
      end

  Options:
  - `:username`  - username (defaults to `""`)
  - `:password`  - password (defaults to `""`)
  """
 import CouchDB.Environment

  def call(env, next, opts) do
    opts = opts || %{}

    env
    |> Map.update!(:headers, &Map.merge(&1, authorization_header(opts)))
    |> Map.update!(:url, &(opts[:url] <> &1))
    |> Tesla.run(next)
  end

  defp authorization_header(opts) do
    opts
    |> authorization_vars()
    |> auth()
    |> create_header()
  end

  defp authorization_vars(opts) do
    %{
      username: opts[:username] || "",
      password: opts[:password] || "",
    }
  end

  defp create_header(auth) do
    %{"Cookie" => "#{auth}"}
  end

  defp auth(%{username: username, password: password}) do
    response = CouchDB.post(base_url() <> "/_session", %{name: username, password: password})
    # case response.body do
    #   resp ->
    #     IO.puts inspect resp
    #   {_} ->
    #     IO.puts inspect response
    # end
    response.headers["set-cookie"]
  end
end
