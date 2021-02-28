defmodule Rocketpay.Users.CreateTest do

  # testes de changeset e database
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "WHen all params are valid, returns an use" do
      params = %{
        name: "Fulano",
        password: "123456",
        nickname: "futuro",
        email: "fulano.turo@futuro.com",
        age: 28
      }

      # Testa a criação do usuário no banco
      {:ok, %User{ id: user_id }} = Create.call(params)
      user = Repo.get(User, user_id)

      # ^ pin operator, pega um valor pre-estabelecido e fixa esse valor
      # como usamos pattern macthing na atribuição de user qualquer outro valor iria passar
      assert %User{
        id: ^user_id,
        name: "Fulano",
        nickname: "futuro",
        email: "fulano.turo@futuro.com",
        age: 28
      } = user
    end

    test "WHen there are invalid params, returns an error" do
      params = %{
        name: "Fulano",
        password: "12346",
        nickname: "futuro",
        email: "fulano.turo@futuro.com",
        age: 12
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(changeset) == expected_response

    end
  end
end
