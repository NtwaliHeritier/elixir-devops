defmodule ExApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExAppWeb.Telemetry,
      ExApp.Repo,
      {DNSCluster, query: Application.get_env(:ex_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ExApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ExApp.Finch},
      # Start a worker by calling: ExApp.Worker.start_link(arg)
      # {ExApp.Worker, arg},
      # Start to serve requests, typically the last entry
      ExAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
