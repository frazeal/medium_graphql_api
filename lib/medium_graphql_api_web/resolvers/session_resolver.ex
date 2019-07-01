defmodule MediumGraphqlApiWeb.Resolvers.SessionResolver do
  alias MediumGraphqlApi.{Accounts, Guardian}

  # 1. Checks if the user is registered
  # 2. If the user is registeres, returns a token
  # 3. Returns the user
  def login_user(_parent, %{input: input}, _resolution) do
    with {:ok, user} <- Accounts.Session.authenticate(input),
         {:ok, jwt_token, _} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt_token, user: user}}
    end
  end
end
