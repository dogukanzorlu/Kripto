# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :kripto, KriptoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9uWlxoiL6v9XGIu9aI62MxQvUh9fLJQGQt4J8cExRKnBG3uBlr8qknNNMwC0Xf5U",
  render_errors: [view: KriptoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Kripto.PubSub,
  live_view: [signing_salt: "6psgjy/D"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
