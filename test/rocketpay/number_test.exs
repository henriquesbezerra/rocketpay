defmodule Rocketpay.NumbersPipeOperatorTest do
  use ExUnit.Case, async: true

  alias Rocketpay.NumbersPipeOperator

  describe "sum_from_file/1" do
    test "When there is a file with the given name, return the sum of numbers" do
      response = NumbersPipeOperator.sum_from_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "When there is no file with the given name, return a error" do
      response = NumbersPipeOperator.sum_from_file("banana")

      expected_response = {:error, %{message: "Invalid File!"}}

      assert response == expected_response
    end
  end

end
