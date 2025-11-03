defmodule PhavoritesElixir.Auth do
  alias PhavoritesElixir.Accounts
  alias PhavoritesElixir.Accounts.User




  def authenticate_user(username, password) do
    with {:ok, user} <- Accounts.get_user_by_username(username),
      true <- Bcrypt.verify_pass(password, user.password_hash) do
      token = generate_jwt(user)
      {:ok, token, user}
    else
      nil -> {:error, :user_not_found}
      false -> {:error, :invalid_credentials}
    end
  end


  def generate_jwt(%User{} = user) do
    secret_key = System.get_env("JWT_SECRET") || "my_secret_key"

    signer = Joken.Signer.create("HS256", secret_key)

    user_claims = %{"username" => user.username, "user_id" => user.id}

    {:ok, token, _claims} = PhavoritesElixir.Token.generate_and_sign(user_claims, signer)

    token
  end
end
