defmodule Pex.Users.CreateTest do
  use Pex.DataCase, async: true
  alias Pex.User
  alias Pex.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Vinicius",
        password: "123456",
        nickname: "limavini",
        email: "viniciusalmeidait@gmail.com",
        age: 22
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Vinicius", age: 22, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Vinicius",
        nickname: "limavini",
        email: "viniciusalmeidait@gmail.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expect_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert(errors_on(changeset) == expect_response)
    end
  end
end
