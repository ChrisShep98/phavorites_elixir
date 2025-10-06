defmodule PhavoritesElixirWeb.SongJSON do
  alias PhavoritesElixir.Music.Song

  @doc """
  Renders a list of songs.
  """
  def index(%{songs: songs}) do
    %{data: for(song <- songs, do: data(song))}
  end

  @doc """
  Renders a single song.
  """
  def show(%{song: song}) do
    %{data: data(song)}
  end

  defp data(%Song{} = song) do
    %{
      id: song.id,
      song_name: song.song_name,
      data: song.data,
      venue_name: song.venue_name,
      venue_location: song.venue_location,
      vote_count: song.vote_count,
      description: song.description,
      slug: song.slug
    }
  end
end
