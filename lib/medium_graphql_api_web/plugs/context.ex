defmodule MediumGraphqlApi.Plugs.Context do
  @behaviour Plug

  import Plug.Conn

  alias MediumGraphqlApi.Guardian

  def init(opts), do: opts

  def call(conn, _opts) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> jwt_token] <- get_req_header(conn, "authorization"),
         {:ok, claims} <- Guardian.decode_and_verify(jwt_token),
         {:ok, user} <- Guardian.resource_from_claims(claims) do
      %{currentUser: user}
    else
      _ -> %{}
    end
  end
end
