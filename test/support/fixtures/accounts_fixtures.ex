defmodule PhavoritesElixir.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhavoritesElixir.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password: "some password",
        profile_picture: "some profile_picture",
        username: "some username"
      })
      |> PhavoritesElixir.Accounts.create_user()

    user
  end
end
