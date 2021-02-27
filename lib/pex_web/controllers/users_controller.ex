defmodule PexWeb.UsersController do
  use PexWeb, :controller

  alias Pex.User

  action_fallback PexWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Pex.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
