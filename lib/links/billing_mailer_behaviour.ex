defmodule BillingMailerBehaviour do
  @callback billing_problem(User.t()) :: User.t()
end
