defmodule Kripto.Repo.Migrations.CreateCryptos do
  use Ecto.Migration

  def change do
    create table(:cryptos) do

      timestamps()
    end

  end
end
