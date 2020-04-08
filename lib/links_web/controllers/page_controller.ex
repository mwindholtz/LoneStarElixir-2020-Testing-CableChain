defmodule LinksWeb.PageController do
  use LinksWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
