defmodule User do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %User{}

  schema "users" do
    field(:name, :string)
    field(:paid_at, :utc_datetime)
    field(:active, :boolean)
  end

  def changeset(%User{} = order, %{} = attrs) do
    order
    |> cast(attrs, [:name, :paid_at, :utc_datetime])
  end

  def new(name, paid_at, active) do
    %User{name: name, paid_at: paid_at, active: active}
  end

  def insert(name, paid_at, :active) do
    Links.Repo.insert(new(name, paid_at, true))
  end

  def insert(name, paid_at, :inactive) do
    Links.Repo.insert(new(name, paid_at, false))
  end
end
