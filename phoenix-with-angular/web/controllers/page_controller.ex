defmodule PhoenixTemplate.PageController do
  use PhoenixTemplate.Web, :controller

  def index(conn, _params) do
    Apex.ap "with Awesome Print!"
    render conn, "index.html"
  end
end
