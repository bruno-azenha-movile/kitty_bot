# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :kitty_bot,
  ecto_repos: [KittyBot.Repo]

# Configures the endpoint
config :kitty_bot, KittyBot.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FEcu/qJzx90N0uj3h7/rsDLoskgjWtJZaeSbHBvcgDQjEwZPDgRAbvUAFrKxcqFW",
  render_errors: [view: KittyBot.ErrorView, accepts: ~w(html json)],
  pubsub: [name: KittyBot.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :facebook_messenger,
   facebook_page_token: System.get_env("FB_PAGE_ACCESS_TOKEN"),
   challenge_verification_token: System.get_env("FB_VERIFICATION_TOKEN")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
