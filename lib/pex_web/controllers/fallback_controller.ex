defmodule PexWeb.FallbackController do
  use PexWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PexWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
