defmodule UserMailer do
  @behaviour BillingMailerBehaviour

  @impl BillingMailerBehaviour
  def billing_problem(%User{} = user) do
    # send a real email here using some external API
    user
  end
end
