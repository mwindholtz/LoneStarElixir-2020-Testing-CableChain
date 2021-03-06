defmodule Links.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string, null: false)
      add(:active, :boolean, default: false)
      add(:paid_at, :utc_datetime)
    end
  end
end
