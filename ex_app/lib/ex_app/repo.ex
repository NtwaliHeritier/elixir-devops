defmodule ExApp.Repo do
  use Ecto.Repo,
    otp_app: :ex_app,
    adapter: Ecto.Adapters.Postgres
end
