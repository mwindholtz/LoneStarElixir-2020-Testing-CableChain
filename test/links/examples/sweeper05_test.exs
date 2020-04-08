defmodule Examples.Sweeper05Test do
  @moduledoc """
  Separates Business from Navigation
  by extracting pure _Overdue_ module
  """
  use Links.DataCase
  alias Examples.Sweeper05Test.UserMailerStub
  alias Examples.Sweeper05
  alias Examples.Sweeper05.Overdue

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
    def billing_problem(%User{} = user) do
      send(self(), {:billing_problem, user.name})
      user
    end
  end

  describe "Cable testing" do
    test "everything connects", %{times: times} do
      User.insert("ace", times.recent, :active)

      pass_thru_fn = fn users -> users end

      Sweeper05.sweep(UserMailerStub, pass_thru_fn)
      assert_receive {:billing_problem, "ace"}
    end
  end

  describe "Chain Link testing" do
    setup do
      times = %{recent: MyTime.utc_now(), expired: MyTime.now_minus(31, :days)}
      %{times: times}
    end

    test "paid and active", %{times: times} do
      users = [%{name: "ace", paid_at: times.recent, active: true}]
      assert [] == Overdue.users(users)
    end

    test "not paid", %{times: times} do
      users = [%{name: "ace", paid_at: times.expired, active: true}]
      assert users == Overdue.users(users)
    end

    test "not active", %{times: times} do
      users = [%{name: "ace", paid_at: times.expired, active: false}]
      assert [] == Overdue.users(users)
    end

    test "not paid and not active", %{times: times} do
      users = [%{name: "ace", paid_at: times.expired, active: false}]
      assert [] == Overdue.users(users)
    end

    test "multiple expired", %{times: times} do
      users = [
        %{name: "ace", paid_at: times.expired, active: true},
        %{name: "bret", paid_at: times.expired, active: true}
      ]

      assert users = Overdue.users(users)
    end
  end
end
