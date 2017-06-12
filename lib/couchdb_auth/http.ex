defmodule CouchDB.HTTP do

  import CouchDB.Environment


  def srv_conn(interface \\ :user) do
    CouchDB.client(interface)
  end

  def db_conn do
    dbprops()[:database]
  end



end
