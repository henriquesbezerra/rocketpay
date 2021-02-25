defmodule RocketpayWeb.FallbackController do
  use RocketpayWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(RocketpayWeb.ErrorView) # Em casos de erros, devemos apontar a view a ser chamada
    |> render("400.json", result: result) # Renderiza Json na resposta
  end

end
