defmodule Tesla.Middleware.CouchDB.OAuth do
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
    IO.puts inspect opts
    env_t = env
    |> Map.update!(:url, &(opts[:url] <> &1))
    {raw_header, params} = authorization_header(env_t, opts)
    header = raw_header |> create_header
    #ToDo: should check if params need formatting in future
    #params = raw_params |> create_options
    env_t1 = env_t
    |> Map.update!(:headers, &Map.merge(&1, header))
    |> Map.update!(:query, &Enum.concat(&1, params))
    IO.inspect env_t1
    env_t1
    |> Tesla.run(next)
  end

  defp authorization_header(env, opts) do
    opts
    |> oauth_credentials()
    |> sign(env)
  end

  defp oauth_credentials(opts) do
    OAuther.credentials(
      consumer_key: opts[:consumer_key],
      consumer_secret: opts[:consumer_secret],
      token: opts[:token],
      token_secret: opts[:token_secret])
  end

  defp sign(oauth_credentials, env) do
    params = OAuther.sign(to_string(Map.get(env, :method)), Map.get(env, :url), Map.get(env, :opts), oauth_credentials)
    OAuther.header(params)
  end

  def create_header(header) do
    {name, value} = header
    %{"#{name}"=>"#{value}"}
  end

  def create_options(params) do
    params
    |> Enum.into(%{})
  end

end
