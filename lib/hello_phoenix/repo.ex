defmodule HelloPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :hello_phoenix,
    adapter: Ecto.Adapters.Postgres
end
