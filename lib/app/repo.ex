defmodule App.Repo do
  use Ecto.Repo,
    otp_app: :app,
    # adapter: Ecto.Adapters.SQLite3
    adapter: Ecto.Adapters.Postgres

  # use Scrivener, page_size: 10
end
