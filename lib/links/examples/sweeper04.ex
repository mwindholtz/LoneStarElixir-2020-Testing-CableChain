defmodule Examples.Sweeper04 do
  def sweep(user_mailer \\ UserMailer) do
    User
    |> Links.Repo.all()
    |> Enum.filter(fn user -> user.active end)
    |> Enum.reject(fn user -> paid_up?(user) end)
    |> Enum.each(fn user -> user_mailer.billing_problem(user) end)
  end

  defp paid_up?(user) do
    pay_by = MyTime.now_minus(30, :days)
    DateTime.compare(user.paid_at, pay_by) == :gt
  end
end
