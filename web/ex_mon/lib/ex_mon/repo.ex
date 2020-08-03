defmodule ExMon.Repo do
  use Ecto.Repo,
    otp_app: :ex_mon,
    adapter: Ecto.Adapters.Postgres
end
