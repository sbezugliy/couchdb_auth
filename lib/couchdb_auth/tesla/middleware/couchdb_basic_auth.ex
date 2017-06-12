defmodule Tesla.Middleware.CouchDB.BasicAuth do
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

  def call(env, next, opts) do
    opts = opts || %{}

    env
    |> Map.update!(:headers, &Map.merge(&1, authorization_header(opts)))
    |> Tesla.run(next)
  end

  defp authorization_header(opts) do
    opts
    |> authorization_vars()
    |> encode()
    |> create_header()
  end

  defp authorization_vars(opts) do
    %{
      username: opts[:username] || "",
      password: opts[:password] || "",
    }
  end

  defp create_header(auth) do
    %{"Authorization" => "Basic #{auth}"}
  end

  defp encode(%{username: username, password: password}) do
    Base.encode64("#{username}:#{password}")
  end
end
