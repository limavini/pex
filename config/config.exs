# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pex,
  ecto_repos: [Pex.Repo]

# Configures the endpoint
config :pex, PexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "g2aa4OKiXbr71txDo3JWrEJpjLyO1hFdUjqmbOBO9bY1Tu9G2YcCNAdGf9gi1iA7",
  render_errors: [view: PexWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Pex.PubSub,
  live_view: [signing_salt: "Rwn166RK"]

config :pex, Pex.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :pex, :basic_auth,
  username: "limavini",
  password: "welcome"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
