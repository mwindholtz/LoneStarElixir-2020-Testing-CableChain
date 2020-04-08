defmodule Examples.Sweeper02 do
  def sweep do
    user_mailer = Application.get_env(:links, :mailer, UserMailer)

    User
    |> Links.Repo.all()
    |> Enum.filter(fn user -> user.active end)
    |> Enum.reject(fn user -> paid_up?(user) end)
    |> Enum.each(fn user -> user_mailer.billing_problem(user) end)
  end

  defp paid_up?(user) do
    Date.utc_today() |> Date.add(-30) |> Date.compare(user.paid_at) == :lt
  end
end
