defmodule Pollutiondb.Station do
  use Ecto.Schema
  alias Pollutiondb.Repo

  schema "stations" do
      field :name, :string
      field :lon, :float
      field :lat, :float
  end

  def add(stations) when is_list(stations) do
    Enum.each(stations, &Repo.insert/1)
  end

  def add(station) do
    Repo.insert(station)
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
end
