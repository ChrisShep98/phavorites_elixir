defmodule PhavoritesElixir.MusicTest do
  use PhavoritesElixir.DataCase

  alias PhavoritesElixir.Music

  describe "songs" do
    alias PhavoritesElixir.Music.Song

    import PhavoritesElixir.MusicFixtures

    @invalid_attrs %{data: nil, description: nil, song_name: nil, venue_name: nil, venue_location: nil, vote_count: nil, slug: nil}

    test "list_songs/0 returns all songs" do
      song = song_fixture()
      assert Music.list_songs() == [song]
    end

    test "get_song!/1 returns the song with given id" do
      song = song_fixture()
      assert Music.get_song!(song.id) == song
    end

    test "create_song/1 with valid data creates a song" do
      valid_attrs = %{data: "some data", description: "some description", song_name: "some song_name", venue_name: "some venue_name", venue_location: "some venue_location", vote_count: 42, slug: "some slug"}

      assert {:ok, %Song{} = song} = Music.create_song(valid_attrs)
      assert song.data == "some data"
      assert song.description == "some description"
      assert song.song_name == "some song_name"
      assert song.venue_name == "some venue_name"
      assert song.venue_location == "some venue_location"
      assert song.vote_count == 42
      assert song.slug == "some slug"
    end

    test "create_song/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Music.create_song(@invalid_attrs)
    end

    test "update_song/2 with valid data updates the song" do
      song = song_fixture()
      update_attrs = %{data: "some updated data", description: "some updated description", song_name: "some updated song_name", venue_name: "some updated venue_name", venue_location: "some updated venue_location", vote_count: 43, slug: "some updated slug"}

      assert {:ok, %Song{} = song} = Music.update_song(song, update_attrs)
      assert song.data == "some updated data"
      assert song.description == "some updated description"
      assert song.song_name == "some updated song_name"
      assert song.venue_name == "some updated venue_name"
      assert song.venue_location == "some updated venue_location"
      assert song.vote_count == 43
      assert song.slug == "some updated slug"
    end

    test "update_song/2 with invalid data returns error changeset" do
      song = song_fixture()
      assert {:error, %Ecto.Changeset{}} = Music.update_song(song, @invalid_attrs)
      assert song == Music.get_song!(song.id)
    end

    test "delete_song/1 deletes the song" do
      song = song_fixture()
      assert {:ok, %Song{}} = Music.delete_song(song)
      assert_raise Ecto.NoResultsError, fn -> Music.get_song!(song.id) end
    end

    test "change_song/1 returns a song changeset" do
      song = song_fixture()
      assert %Ecto.Changeset{} = Music.change_song(song)
    end
  end
end
