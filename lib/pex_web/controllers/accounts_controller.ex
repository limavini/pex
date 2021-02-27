defmodule PexWeb.AccountsController do
  use PexWeb, :controller

  alias Pex.Account
  alias Pex.Accounts.Transaction.Response, as: TransactionResponse
  action_fallback PexWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Pex.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Pex.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, %TransactionResponse{} = transaction} <- Pex.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
