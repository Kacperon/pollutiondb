defmodule Pollutiondb.Station do
  use Ecto.Schema
  alias Pollutiondb.Repo
  import Ecto.Query
  import Ecto.Changeset

  schema "stations" do
      field :name, :string
      field :lon, :float
      field :lat, :float

      has_many :readings, Pollutiondb.Reading
  end

  def add(stations) when is_list(stations) do
    Enum.each(stations, &Repo.insert/1)
  end

  def add(station) do
    Repo.insert(station)
  end

  def add(name, lon, lat) do
    %Pollutiondb.Station{}
    |> changeset(%{name: name, lon: lon, lat: lat})
    |> Repo.insert()
  end

  def update_name(station, newname) do
    station
    |> cast(%{name: newname}, [:name])
    |> validate_required([:name])
    |> Repo.update()
  end

  defp changeset(station, attrs) do
    station
    |> cast(attrs, [:name, :lon, :lat])
    |> validate_required([:name, :lon, :lat])
    |> validate_number(:lon, greater_than_or_equal_to: -180, less_than_or_equal_to: 180)
    |> validate_number(:lat, greater_than_or_equal_to: -90, less_than_or_equal_to: 90)
  end

  def get_all do
    Repo.all(Pollutiondb.Station)
  end

  def get_by_id(id) do
    Repo.get(Pollutiondb.Station, id)
  end

  def remove(station) do
    Repo.delete(station)
  end

  def find_by_name(name) do
    Pollutiondb.Repo.all(
      Ecto.Query.where(Pollutiondb.Station, name: ^name)
    )
  end

  def find_by_location(lon, lat) do
    Ecto.Query.from(s in Pollutiondb.Station,
      where: s.lon == ^lon,
      where: s.lat == ^lat)
      |> Pollutiondb.Repo.all
  end

  def find_by_location_range(lon_min, lon_max, lat_min, lat_max) do
    Ecto.Query.from(s in Pollutiondb.Station,
      where: s.lon >= ^lon_min,
      where: s.lon <= ^lon_max,
      where: s.lat >= ^lat_min,
      where: s.lat <= ^lat_max)
      |> Pollutiondb.Repo.all
  end
end
