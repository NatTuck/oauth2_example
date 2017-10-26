defmodule OAuth2Example.User do
  use OAuth2Example.Web, :model
  alias OAuth2Example.Repo

  schema "users" do
    field :name, :string
    field :token, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :token])
    |> validate_required([:name, :token])
  end

  # This stuff should be in a context module, Phoenix 1.2
  # didn't give us one.

  def find_or_empty(name) do
    user = Repo.get_by(OAuth2Example.User, name: name)
    if user do
      user
    else
      %OAuth2Example.User{name: name}
    end
  end

  def insert_or_update(params) do
    user = find_or_empty(params.name)
    Repo.insert_or_update!(changeset(user, params))
  end
end
