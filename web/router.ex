defmodule KittyBot.Router do
  use KittyBot.Web, :router
  use FacebookMessenger.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KittyBot do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  facebook_routes "/api/webhook", KittyBot.BotController

  # Other scopes may use custom stacks.
  # scope "/api", KittyBot do
  #   pipe_through :api
  # end
end
