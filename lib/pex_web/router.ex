defmodule PexWeb.Router do
  use PexWeb, :router
  import Plug.BasicAuth

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(:basic_auth, Application.compile_env!(:pex, :basic_auth))
  end

  scope "/api", PexWeb do
    pipe_through(:api)

    get("/:filename", WelcomeController, :index)
  end

  scope "/api", PexWeb do
    pipe_through([:api, :auth])

    post("/users", UsersController, :create)
    post("/accounts/:id/deposit", AccountsController, :deposit)
    post("/accounts/:id/withdraw", AccountsController, :withdraw)
    post("/accounts/transaction", AccountsController, :transaction)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: PexWeb.Telemetry)
    end
  end
end
