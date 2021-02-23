defmodule Rocketpay.Numbers do
  # String sempre com aspas duplas
  def sum_from_file(filename) do
    # Fazemos uma interpolação da nossa variavel com a extensão
    # para acharmos nosso arquivo
    # Para testarmos pelo terminal utiliza o modo interativo iex com os parametro -S mix
    # onde podemos rodar nossos módulos, passamos o nome do módulo e o nome da função que
    # queremos executar. Nesse caso Rocketpay.Numbers.sum_from_file("numbers")
    # nossa retorno será uma estrutura de dados do tipo tupla

    # usamos o pattern matching
    # em Elixir o simbolo de igualdade não representa atribuição, representa matching
    #{:ok, file} = File.read("#{filename}.csv")

    # contornando o erro :enoent
    file = File.read("#{filename}.csv")
    handle_file(file)

  end

  # sugar sintaxe, de função de linha única
  defp handle_file({:ok, file}), do: file
  defp handle_file({:error, _reason}), do: {:error, "Invalid File!"}

end


# Pipe Operator, para repassar o primeiro argumento implicitamente de uma função a outra
defmodule Rocketpay.NumbersPipeOperator do
  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end

  # Enum -> enumarable
  # função anonima fn...end
  # Percorremos a lista e convertemos cada item para inteiro
  defp handle_file({:ok, result}) do
    result =
      result
      |> String.split(",")
      # |> Enum.map(fn number -> String.to_integer(number) end)
      # Stream é um operador lazy,
      |> Stream.map(fn number -> String.to_integer(number) end)
      |> Enum.sum()

    {:ok, %{result: result} }
    # {:error, "Some thing it's wrong!" }
  end

  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid File!"}}

end
