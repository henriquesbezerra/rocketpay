defmodule Rocketpay.User do

  # Definimos o Schema, que mapea os dados, é parecido com models
  # porém só faz mapeamento de dados
  # Use e import tras as funcionalidades do ecto para esse módulo
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  # Variável de módulo especial @primary_key que definimos
  # o formato da chave primária no banco
  # o valor :binary_id diz ao banco que usaremo uuid
  # e o autogenerate diz que uuid será gerado automáticamente
  @primary_key {:id, :binary_id, autogenerate: true}

  # podemos gerar uuid pelo iex com Ecto.UUID.generate()

  @required_params [:name, :age, :email, :password, :nickname]

  # atoms são string constante no modelo

  # Definição do Schema
  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    # definimos um campo password virtual, que é um campo que só existe no Schema
    # vamos usar ele pra receber o dado que será guardado em password_hasg
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string

    has_one :account, Rocketpay.Account

    timestamps()
  end

  # changeset é uma estrutura responsável para falar para o banco de dados
  # "Olha banco, vou adicionar na tabela definada pelo schema esses dados"
  # Changeset faz validações
  # e também faz o mapeamento dos dados
  def changeset(params) do
    %__MODULE__{} # Uma struct vazia
    |> cast(params, @required_params) # Mapea os dados que recemos para os tipos do schema
    |> validate_required(@required_params) # Parametros required

    # Exemplo validação password com tamanho minimo
    |> validate_length(:password, min: 6)

    # Validação idade menor ou igual a 18
    |> validate_number(:age, greater_than_or_equal_to: 18)

    # Validação usando regex
    |> validate_format(:email, ~r/@/)

    # Validação para campos unicos
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])

    #
    |> put_password_hash()

  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    # retornamos um novo map com o campo password_hash criptografado
    # que vai então ser gravado
    change(changeset, Bcrypt.add_hash(password))
  end

  # Se recebermos um changeset inválido vamos apenas devolver esse changeset inválido para quem salvou
  defp put_password_hash(changeset), do: changeset
end
