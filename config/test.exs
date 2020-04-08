use Mix.Config

config :links, :mailer, UserMailer

# Configure your database
config :links, Links.Repo,
  username: "postgres",
  password: "postgres",
  database: "links_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :links, LinksWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :links, :utc_now_fn, fn ->
  {:ok, expected} = ~N[2020-02-01 12:00:00] |> DateTime.from_naive("Etc/UTC")
  expected
end
