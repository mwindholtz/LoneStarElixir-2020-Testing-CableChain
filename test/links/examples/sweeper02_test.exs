defmodule Examples.Sweeper02Test do
  use Links.DataCase
  alias Examples.Sweeper02Test.UserMailerStub
  alias Examples.Sweeper02

  setup do
    expired_at =
      DateTime.utc_now()
      |> DateTime.truncate(:second)
      |> MyTime.minus(31, :days)

    %{expired_at: expired_at}
  end

  defmodule UserMailerStub do
    @behaviour BillingMailerBehaviour
    @impl BillingMailerBehaviour
    def billing_problem(user) do
      send(self(), {:billing_problem, user.name})
      user
    end
  end

  test "billing problems", %{expired_at: expired_at} do
    User.insert("ace", expired_at, :active)

    old_mailer = Application.get_env(:links, :mailer)

    Application.put_env(:links, :mailer, UserMailerStub)

    on_exit(fn -> Application.put_env(:links, :mailer, old_mailer) end)

    Sweeper02.sweep()

    assert_receive {:billing_problem, "ace"}
  end

  test "ace has not paid. bret, and carl are ok" do
    # ...
  end

  test "bret is not active. ace and carl are ok" do
    # ...
  end

  test "bret is not active. ace has not paid.carl is ok" do
    # ...
  end
end
