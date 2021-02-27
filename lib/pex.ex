defmodule Pex do
  alias Pex.Users.Create, as: UserCreate

  alias Pex.Accounts.Deposit
  alias Pex.Accounts.Withdraw
  alias Pex.Accounts.Transaction

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
