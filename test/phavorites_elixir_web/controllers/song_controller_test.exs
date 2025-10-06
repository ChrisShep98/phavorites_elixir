defmodule PhavoritesElixirWeb.SongControllerTest do
  use PhavoritesElixirWeb.ConnCase

  import PhavoritesElixir.MusicFixtures
  alias PhavoritesElixir.Music.Song

  @create_attrs %{
    data: "some data",
    description: "some description",
    song_name: "some song_name",
    venue_name: "some venue_name",
    venue_location: "some venue_location",
    vote_count: 42,
    slug: "some slug"
  }
  @update_attrs %{
    data: "some updated data",
    description: "some updated description",
    song_name: "some updated song_name",
    venue_name: "some updated venue_name",
    venue_location: "some updated venue_location",
    vote_count: 43,
    slug: "some updated slug"
  }
  @invalid_attrs %{data: nil, description: nil, song_name: nil, venue_name: nil, venue_location: nil, vote_count: nil, slug: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all songs", %{conn: conn} do
      conn = get(conn, ~p"/api/songs")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create song" do
    test "renders song when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/songs", song: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/songs/#{id}")

      assert %{
               "id" => ^id,
               "data" => "some data",
               "description" => "some description",
               "slug" => "some slug",
               "song_name" => "some song_name",
               "venue_location" => "some venue_location",
               "venue_name" => "some venue_name",
               "vote_count" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/songs", song: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update song" do
    setup [:create_song]

    test "renders song when data is valid", %{conn: conn, song: %Song{id: id} = song} do
      conn = put(conn, ~p"/api/songs/#{song}", song: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/songs/#{id}")

      assert %{
               "id" => ^id,
               "data" => "some updated data",
               "description" => "some updated description",
               "slug" => "some updated slug",
               "song_name" => "some updated song_name",
               "venue_location" => "some updated venue_location",
               "venue_name" => "some updated venue_name",
               "vote_count" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, song: song} do
      conn = put(conn, ~p"/api/songs/#{song}", song: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete song" do
    setup [:create_song]

    test "deletes chosen song", %{conn: conn, song: song} do
      conn = delete(conn, ~p"/api/songs/#{song}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/songs/#{song}")
      end
    end
  end

  defp create_song(_) do
    song = song_fixture()

    %{song: song}
  end
end
