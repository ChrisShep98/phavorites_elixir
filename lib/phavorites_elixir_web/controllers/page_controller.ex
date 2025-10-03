defmodule PhavoritesElixirWeb.PageController do
  use PhavoritesElixirWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
