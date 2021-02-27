defmodule PexWeb.AccountsControllerTest do
  use PexWeb.ConnCase, async: true
  alias Pex.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      user_params = %{
        name: "Vinicius",
        password: "123456",
        nickname: "limavini",
        email: "viniciusalmeidait@gmail.com",
        age: 22
      }

      {:ok, %User{account: %Account{id: account_id}}} = Pex.create_user(user_params)
      conn = put_req_header(conn, "authorization", "Basic bGltYXZpbmk6d2VsY29tZQ==")
      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
               "account" => %{"balance" => "50.00", "id" => _id},
               "message" => "Balance updated successfully!"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "banana"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid deposit value!"} = response
    end
  end
end
