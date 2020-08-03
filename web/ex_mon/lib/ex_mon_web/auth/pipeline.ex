defmodule ExMonWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :ex_mon

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
