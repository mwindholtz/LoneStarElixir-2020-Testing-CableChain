defmodule Examples.Sweeper03Test do
  use Links.DataCase
  alias Examples.Sweeper03Test.UserMailerStub
  alias Examples.Sweeper03

  setup do
    expired_at =
      DateTime.utc_now()
      |> DateTime.truncate(:second)
      |> MyTime.minus(31, :days)

    %{expired_at: expired_at}
  end

  defmodule UserMailerStub do
    def billing_problem(user) do
      send(self(), {:billing_problem, user.name})
      user
    end
  end

  test "bret is expired", %{expired_at: expired_at} do
    User.insert("bret", expired_at, :active)

    Sweeper03.sweep(UserMailerStub)

    assert_receive {:billing_problem, "bret"}
  end

  test "bret is not active" do
    # ...
  end
end
