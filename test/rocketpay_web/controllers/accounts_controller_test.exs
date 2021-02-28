defmodule RocketpayWeb.AccountsControllerTest do

  # ConnCase testes de controller
  use RocketpayWeb.ConnCase

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    # Setup do teste, já que precisamos de algumas coisas
    # como um usuário
    setup %{conn: conn} do
      params = %{
        name: "Fulano",
        password: "123456",
        nickname: "futuro",
        email: "fulano.turo@futuro.com",
        age: 28
      }

      {:ok, %User{
        account: %Account{id: account_id}
      }} = Rocketpay.create_user(params)

      # Basic YmFuYW5hOmJhbmFuYQ== gerado através de Base.encode64("banana:banana")
      conn = put_req_header(conn, "authorization", "Basic #{Base.encode64("banana:banana")}")

      # no final de todo setup de teste de controller temos que passar uma tupla
      # passando :ok e conn,
      {:ok, conn: conn, account_id: account_id}
    end

    test "When all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{
        "value" => "50.00"
      }

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:ok)

      assert %{
        "account" => %{
          "balance" => "50.00",
          "id" => _id
          },
        "message" => "Ballance changed successfully"
      } = response
    end

    test "When there are invalid params, return an error", %{conn: conn, account_id: account_id} do
      params = %{
        "value" => "banana"
      }

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:bad_request)

      expect_response = %{"message" => "Invalid deposit value!"}

      assert response = expect_response

    end

  end

end
