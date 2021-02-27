defmodule Rocketpay do
  # Definimos um alias para nosso módulo user
  # com o padrão facade dizemos que temos um módulos principal
  # com várias funcionalidades
  alias Rocketpay.Users.Create, as: UserCreate
  alias Rocketpay.Accounts.{ Deposit, Withdraw, Transaction }

  defdelegate create_user(params), to: UserCreate, as: :call_multi
  # agora podemos chamar Rocketpay.create_user(params)

  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
