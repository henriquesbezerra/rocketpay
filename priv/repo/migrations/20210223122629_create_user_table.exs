defmodule Rocketpay.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  # Função change fica preparada para criação e rollback
  def change do

    # O Campo id é definido implicitamente como :integer

    create table :users do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password_hash, :string
      add :nickname, :string

      # Adiciona inserted_at e updated_at
      timestamps()
    end

    # Criação do Unique Index (Chave primária)
    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])

  end

  # Podemos usar também de forma separada as ações de migrate e rollback

  # o que é feito na migração
  #def up do

  #end

  # o que é feito no rollback
  #def down do

  #end

end
