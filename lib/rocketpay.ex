defmodule Rocketpay do
  # Definimos um alias para nosso módulo user
  # com o padrão facade dizemos que temos um módulos principal
  # com várias funcionalidades
  alias Rocketpay.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
  # agora podemos chamar Rocketpay.create_user(params)
end
