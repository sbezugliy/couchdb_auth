defmodule CouchDB.HTTP.Headers do

  import CouchDB.Environment

  def accept(type \\ :json) do
    case type do
      :json ->
        %{"Accept" => "application/json"}
      :text ->
        %{"Accept" => "text/plain"}
    end
  end

  def content_type(type \\ :json) do
    case type do
      :json ->
        %{"Content-Type" => "application/json"}
      :text ->
        %{"Content-Type" => "text/plain"}
    end
  end

  def host do
    %{"Host" => (dbprops()[:hostname] <> ":" <> dbprops()[:port])}
  end

  # ToDo: add check on header presence in map, and skip adding if present
  def add_header(headers, header) do
    headers
    |> Map.merge(header)
  end
end
