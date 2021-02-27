defmodule PexWeb.WelcomeController do
  use PexWeb, :controller

  alias Pex.Numbers

  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcome to Pex API. Here is your number #{result}"})
  end

  defp handle_response({:error, %{message: message}}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: message})
  end
end
