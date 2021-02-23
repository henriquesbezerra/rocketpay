# Um módulo é um agrupamento de funções
# Definimos um módulo dentro do contexto ao qual ele pertence
defmodule RocketpayWeb.WelcomeController do

  # definimos esse módulo como um controller
  use RocketpayWeb, :controller

  alias Rocketpay.NumbersPipeOperator

  # Criamos um função chamada index, as funções no controller recebem dois parametros
  # a conn de conexão e params (colocamos _ na frente para que seja ignorado esse parametro)
  def index_old(conn, _params) do
    # vamos retornar um texto para testar
    # passamos a conexão e o texto a retornar
    # a conn é uma struct !
    text(conn, "Welcome Phoenix API!")
  end

  def index(conn, %{ "filename" => filename }) do
    filename
    |> NumbersPipeOperator.sum_from_file()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    |> IO.inspect()
    |> json(%{message: "Welcome to Rocketpay API. Here is your number #{result}"})
  end

  defp handle_response({:error, reason}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(reason)
  end

end
