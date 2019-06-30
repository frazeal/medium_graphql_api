defmodule MediumGraphqlApiWeb.Resolvers.UserResolver do
  alias MediumGraphqlApi.Accounts

  def users(_parent, _args, _context) do
    {:ok, Accounts.list_users()}
  end

  def register_user(_parent, %{input: input}, _context) do
    Accounts.create_user(input)
  end
end
