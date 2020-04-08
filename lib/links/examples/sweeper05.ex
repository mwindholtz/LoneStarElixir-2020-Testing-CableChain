defmodule Examples.Sweeper05 do
  alias Examples.Sweeper05.Overdue

  def sweep(
        user_mailer \\ UserMailer,
        filter \\ &Overdue.users/1
      ) do
    User
    |> Links.Repo.all()
    |> filter.()
    |> Enum.each(fn user -> user_mailer.billing_problem(user) end)
  end
end

defmodule Examples.Sweeper05.Overdue do
  def users(users) do
    users
    |> Enum.filter(fn user -> user.active end)
    |> Enum.reject(fn user -> paid_up?(user) end)
  end

  # ...
  defp paid_up?(user) do
    pay_by = MyTime.now_minus(30, :days)
    DateTime.compare(user.paid_at, pay_by) == :gt
  end
end
