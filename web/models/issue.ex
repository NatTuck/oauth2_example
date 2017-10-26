defmodule OAuth2Example.Issue do
  use OAuth2Example.Web, :model

  schema "issues" do
    field :title, :string
    field :body, :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
  end

  # This should go in ./lib
  # Phoenix 1.2 doesn't hot code reload lib though...

  def get_client(user) do
    GitHub.client(user.token)
  end

  def path do
    "/repos/NatTuck/oauth2_example/issues"
  end

  def list(user) do
    client = get_client(user)
    resp = OAuth2.Client.get!(client, path())
    IO.inspect(resp)
    resp.body
  end

  def create(user, issue) do
    client = get_client(user)
    resp = OAuth2.Client.post!(client, path(), issue)
    IO.inspect(resp)
    {:ok, resp.body}
  end

  def delete!(user, issue_id) do

  end
end
