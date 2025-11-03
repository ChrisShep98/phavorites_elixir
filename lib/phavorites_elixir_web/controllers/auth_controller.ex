defmodule PhavoritesElixirWeb.AuthController do
  use PhavoritesElixirWeb, :controller
  alias PhavoritesElixir.Auth


  def login(conn, %{"username" => username, "password" => password}) do
    case Auth.authenticate_user(username, password) do
      {:ok, token, user} ->
        conn
        |> put_resp_cookie("jwt", token, max_age: 240 * 60)
        |> json(%{
          message: "Login successful",
          token: token,
          username: user.username,
          user_id: user.id,
          email: user.email,
        })

      {:error, reason} ->
        message =
          case reason do
            :invalid_credentials -> "Invalid credentials"
            :user_not_found -> "User not found"
          end
        conn
        |> put_status(:unauthorized)
        |> json(%{error: message})
    end
  end
end
