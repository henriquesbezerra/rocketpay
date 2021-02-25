defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account

  # definimos o callback que criamos
  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  # defp withdraw({:ok, %User{} = user}, conn) do
  #   conn
  #   |> put_status(:created)
  #   |> render("create.json", user: user)
  # end

end
