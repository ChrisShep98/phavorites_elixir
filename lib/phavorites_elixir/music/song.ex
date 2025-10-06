defmodule PhavoritesElixir.Music.Song do
  use Ecto.Schema
  import Ecto.Changeset

  schema "songs" do
    field :song_name, :string
    field :data, :string
    field :venue_name, :string
    field :venue_location, :string
    field :vote_count, :integer
    field :description, :string
    field :slug, :string

    belongs_to :voted_by, PhavoritesElixir.Accounts.User
    belongs_to :user_who_posted, PhavoritesElixir.Accounts.User

    has_many :comments, PhavoritesElixir.Music.Comment


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(song, attrs) do
    song
    |> cast(attrs, [:song_name, :data, :venue_name, :venue_location, :vote_count, :description, :slug])
    |> validate_required([:song_name, :data, :venue_name, :venue_location, :vote_count, :description, :slug])
  end
end
