defmodule CouchDB.Supervisor do
  use Supervisor
  @moduledoc """
  Supervisor module for CouchDB adapter.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CouchDB.hello
      :world

  """

    def start_link do
      Supervisor.start_link(__MODULE__, :ok)
    end

    def init(:ok) do
      children = [
        worker(CouchDB.Environment, [CouchDB.Environment])
      ]

      supervise(children, strategy: :one_for_one)
    end
end
