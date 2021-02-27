defmodule Pex.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  # Can also be up() and down()
  def change do
    create table :users do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password_hash, :string
      add :nickname, :string

      timestamps()
    end

    # Defining that fields are unique
    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])

  end
end
