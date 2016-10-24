defmodule KittyBot.PageController do
  use KittyBot.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
