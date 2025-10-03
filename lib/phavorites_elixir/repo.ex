defmodule PhavoritesElixir.Repo do
  use Ecto.Repo,
    otp_app: :phavorites_elixir,
    adapter: Ecto.Adapters.Postgres
end
