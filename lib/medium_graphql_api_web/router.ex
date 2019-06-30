defmodule MediumGraphqlApiWeb.Router do
  use MediumGraphqlApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", MediumGraphqlApiWeb do
    pipe_through(:api)

    if Mix.env() == :dev do
      forward("/graphiql", Absinthe.Plug.GraphiQL, schema: MediumGraphqlApiWeb.Schema)
    else
      forward("/graphql", Absinthe.Plug, schema: MediumGraphqlApiWeb.Schema)
    end
  end
end
