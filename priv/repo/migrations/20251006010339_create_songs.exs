defmodule PhavoritesElixir.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :song_name, :string
      add :data, :string
      add :venue_name, :string
      add :venue_location, :string
      add :vote_count, :integer
      add :description, :string
      add :slug, :string
      add :voted_by, references(:users, on_delete: :nothing)
      add :user_who_posted, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:songs, [:voted_by])
    create index(:songs, [:user_who_posted])
  end
end
