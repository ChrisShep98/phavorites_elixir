defmodule PhavoritesElixirWeb.CommentControllerTest do
  use PhavoritesElixirWeb.ConnCase

  import PhavoritesElixir.MusicFixtures
  alias PhavoritesElixir.Music.Comment

  @create_attrs %{
    comment: "some comment"
  }
  @update_attrs %{
    comment: "some updated comment"
  }
  @invalid_attrs %{comment: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all comments", %{conn: conn} do
      conn = get(conn, ~p"/api/comments")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create comment" do
    test "renders comment when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/comments", comment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/comments/#{id}")

      assert %{
               "id" => ^id,
               "comment" => "some comment"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/comments", comment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update comment" do
    setup [:create_comment]

    test "renders comment when data is valid", %{conn: conn, comment: %Comment{id: id} = comment} do
      conn = put(conn, ~p"/api/comments/#{comment}", comment: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/comments/#{id}")

      assert %{
               "id" => ^id,
               "comment" => "some updated comment"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, comment: comment} do
      conn = put(conn, ~p"/api/comments/#{comment}", comment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete comment" do
    setup [:create_comment]

    test "deletes chosen comment", %{conn: conn, comment: comment} do
      conn = delete(conn, ~p"/api/comments/#{comment}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/comments/#{comment}")
      end
    end
  end

  defp create_comment(_) do
    comment = comment_fixture()

    %{comment: comment}
  end
end
