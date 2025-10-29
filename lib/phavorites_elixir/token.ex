defmodule PhavoritesElixir.Token do
  use Joken.Config

  def token_config() do
    default_claims(
      iss: "phavorites_app",
      aud: "phavorites_users"
    )
  end

end
