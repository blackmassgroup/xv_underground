import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :v_exchange, VExchange.Repo.Local,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "v_exchange_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :v_exchange, VExchangeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "3Dlb8R6EVYeykaDi6mvKK4HT68aDydUXURE0Yv84oNyclVDUZI8dPMxrJ//qOK2L",
  server: false

# In test we don't send emails.
config :v_exchange, VExchange.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :v_exchange, Oban, testing: :inline

config :paraxial,
  paraxial_api_key: System.get_env("PARAXIAL_TEST_API_KEY"),
  paraxial_url: "https://app.paraxial.io",
  fetch_cloud_ips: false
