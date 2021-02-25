
defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  # definimos o callback que criamos
  action_fallback RocketpayWeb.FallbackController

  # Recebe os parametros enviados por post
  # enviamos esses dados para a lógica da aplicação
  # que serão tratados no schema, validados e salvo no banco
  def create(conn, params) do
    params
    |> Rocketpay.create_user()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %User{} = user}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", user: user)
  end

  # Versão 2 da função create usando uma nova forma de lidar com
  def create2(conn, params) do
    # With verifica um caso, se funcionar executa o corpo da função
    # caso ele falhe, o erro é retornado para que o chamou (phoenix)
    # como definimos um fallback controller o erro irá para o fallback
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
