defmodule MediaApi.Repo do
  use Ecto.Repo,
    otp_app: :media_api,
    adapter: Ecto.Adapters.Postgres
end
