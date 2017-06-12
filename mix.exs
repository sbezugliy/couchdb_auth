defmodule CouchDB.Mixfile do
  use Mix.Project

  def project do
    [app: :couchdb_auth,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     description: description(),
     source: "https://github.com/sbezugliy/couchdb_auth.git",
     deps: deps(),
     dialyzer: [plt_add_apps: [:poison],
     plt_add_deps: :project]
   ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:tesla, :hackney, :oauther, :logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:tesla, "~> 0.7.0"},
      {:hackney, "~> 1.6"},
      {:poison, "~> 3.0"},
      {:oauther, "~> 1.1"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

  defp description do
    """
    CouchDB HTTP authorization package
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Sergey Bezugliy"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/sbezugliy/couchdb_auth"}
    ]
  end
end
