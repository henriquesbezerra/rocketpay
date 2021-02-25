defmodule Rocketpay.Accounts.Deposit do

  alias Rocketpay.{Repo, Account}
  alias Ecto.Multi

  def call(%{"id" => id} = params) do
    Multi.new()
    |> Multi.run(:account, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{account: account} ->
      update_balance(repo, account) end)
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nill -> {:error, "Account, not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account) do

  end
end
