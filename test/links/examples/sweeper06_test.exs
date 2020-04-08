defmodule Examples.Sweeper06Test do
  use Links.DataCase
  alias Examples.Sweeper06Test.UserMailerParrot
  alias Examples.Sweeper05

  setup do
    times = %{
      recent: MyTime.utc_now(),
      expired: MyTime.now_minus(31, :days)
    }

    %{times: times}
  end

  defmodule UserMailerParrot do
    use TestParrot
    @behaviour BillingMailerBehaviour
    parrot(:user_mailer, :billing_problem, [])
  end

  test "everything connects using TestParrot", %{times: times} do
    User.insert("ace", times.recent, :active)
    pass_thru_fn = fn users -> users end

    Sweeper05.sweep(UserMailerParrot, pass_thru_fn)

    assert_receive {:billing_problem, ace}
    assert ace.name == "ace"
  end
end
