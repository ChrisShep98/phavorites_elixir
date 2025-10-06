defmodule PhavoritesElixir.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :comment, :string
      add :song_id, references(:songs, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:comments, [:song_id])
    create index(:comments, [:user_id])
  end
end
