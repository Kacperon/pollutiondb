defmodule Pollutiondb.Reading do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pollutiondb.Repo

  schema "readings" do
    field :date, :date
    field :time, :time
    field :type, :string
    field :value, :float

    belongs_to :station, Pollutiondb.Station

    timestamps()
  end

  def changeset(reading, attrs) do
    reading
    |> cast(attrs, [:date, :time, :type, :value, :station_id])
    |> validate_required([:date, :time, :type, :value, :station_id])
    |> foreign_key_constraint(:station_id)
  end
end
