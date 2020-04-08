defmodule Examples.Sweeper04Test do
  @moduledoc """
  Replaces DateTime with MyTime
  """
  use Links.DataCase
  alias Examples.Sweeper04Test.UserMailerStub
  alias Examples.Sweeper04

  setup do
    times = %{
      recent: MyTime.utc_now(),
      expired: MyTime.now_minus(31, :days)
    }

    %{times: times}
  end

  defmodule UserMailerStub do
    @behaviour BillingMailerBehaviour
    @impl BillingMailerBehaviour
    def billing_problem(user) do
      send(self(), {:billing_problem, user.name})
      user
    end
  end

  test "carl is expired", %{times: times} do
    User.insert("carl", times.expired, :active)

    Sweeper04.sweep(UserMailerStub)

    assert_receive {:billing_problem, "carl"}
  end

  test "carl is ok", %{times: times} do
    User.insert("carl", times.recent, :active)

    Sweeper04.sweep(UserMailerStub)

    refute_receive {:billing_problem, "carl"}
  end

  test "carl is not active" do
    # ...
  end
end
