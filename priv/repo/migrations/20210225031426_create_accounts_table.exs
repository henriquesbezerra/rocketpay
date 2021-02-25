defmodule Rocketpay.Repo.Migrations.CreateAccountsTable do
  use Ecto.Migration

  def change do
    create table :accounts do
      # Importante usar :decimal para valores monetarios
      add :balance, :decimal
      add :user_id, references(:users, type: :binary_id)

      timestamps()
    end

    # constraint adicionar funcionalidades ao BD?
    # essa constraint no caso fará com que o banco de dados nunca aceite um saldo negativo
    create constraint(:accounts, :balance_must_be_positive_or_zero, check: "balance >= 0")

  end
end
