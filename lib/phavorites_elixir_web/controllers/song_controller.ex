defmodule PhavoritesElixirWeb.SongController do
  use PhavoritesElixirWeb, :controller

  alias PhavoritesElixir.Music
  alias PhavoritesElixir.Music.Song

  action_fallback PhavoritesElixirWeb.FallbackController

  def index(conn, _params) do
    songs = Music.list_songs()
    render(conn, :index, songs: songs)
  end

  def create(conn, %{"song" => song_params}) do
    with {:ok, %Song{} = song} <- Music.create_song(song_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/songs/#{song}")
      |> render(:show, song: song)
    end
  end

  def show(conn, %{"id" => id}) do
    song = Music.get_song!(id)
    render(conn, :show, song: song)
  end

  def update(conn, %{"id" => id, "song" => song_params}) do
    song = Music.get_song!(id)

    with {:ok, %Song{} = song} <- Music.update_song(song, song_params) do
      render(conn, :show, song: song)
    end
  end

  def delete(conn, %{"id" => id}) do
    song = Music.get_song!(id)

    with {:ok, %Song{}} <- Music.delete_song(song) do
      send_resp(conn, :no_content, "")
    end
  end
end
