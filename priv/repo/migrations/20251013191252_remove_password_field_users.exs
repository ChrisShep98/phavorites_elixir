defmodule PhavoritesElixir.Repo.Migrations.RemovePasswordFieldUsers do
  use Ecto.Migration

  def change do
alter table(:users) do
  remove :password, :string
end
  end
end
