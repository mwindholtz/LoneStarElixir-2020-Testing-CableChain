defmodule Examples.Sweeper01 do
  def sweep do
    User
    |> Links.Repo.all()
    |> Enum.filter(fn user -> user.active end)
    |> Enum.reject(fn user -> paid_up?(user) end)
    |> Enum.each(fn user -> UserMailer.billing_problem(user) end)
  end

  defp paid_up?(user) do
    pay_by = DateTime.utc_now() |> MyTime.minus(30, :days)
    DateTime.compare(user.paid_at, pay_by) == :gt
  end
end
