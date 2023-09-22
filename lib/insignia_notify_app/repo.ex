defmodule InsigniaNotifyApp.Repo do
  use Ecto.Repo,
    otp_app: :insignia_notify_app,
    adapter: Ecto.Adapters.Postgres
end
