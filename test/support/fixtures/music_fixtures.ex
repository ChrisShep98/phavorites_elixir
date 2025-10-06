defmodule PhavoritesElixir.MusicFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhavoritesElixir.Music` context.
  """

  @doc """
  Generate a song.
  """
  def song_fixture(attrs \\ %{}) do
    {:ok, song} =
      attrs
      |> Enum.into(%{
        data: "some data",
        description: "some description",
        slug: "some slug",
        song_name: "some song_name",
        venue_location: "some venue_location",
        venue_name: "some venue_name",
        vote_count: 42
      })
      |> PhavoritesElixir.Music.create_song()

    song
  end
end
