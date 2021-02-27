defmodule PexWeb.UsersViewTest do
  use PexWeb.ConnCase, async: true
  import Phoenix.View
  alias Pex.{Account, User}
  alias PexWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Vinicius",
      password: "123456",
      nickname: "limavini",
      email: "viniciusalmeidait@gmail.com",
      age: 22
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Pex.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Vinicius",
        nickname: "limavini"
      }
    }

    assert expected_response == response
  end
end
