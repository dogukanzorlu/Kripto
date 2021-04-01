defmodule KriptoWeb.PagesController do
  use KriptoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
