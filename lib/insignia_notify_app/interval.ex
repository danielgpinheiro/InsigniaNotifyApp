defmodule InsigniaNotifyApp.Interval do
  use GenServer, restart: :transient

  alias InsigniaNotifyAppWeb.GamesController
  alias InsigniaNotifyAppWeb.NotificationController

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  @impl true
  def init(opts) do
    IO.puts("InsigniaNotifyAppWeb.Interval Job init")

    {_, interval_time_string} = System.fetch_env("INTERVAL_TIME")
    {interval_time, _} = Integer.parse(interval_time_string)

    Process.send_after(self(), :get_and_parse_job, interval_time)
    Process.send_after(self(), :check_to_send_notification_to_users, interval_time + 10000)

    GamesController.init()

    {:ok, opts}
  end

  @impl true
  def handle_info(:get_and_parse_job, state) do
    clock =
      DateTime.utc_now()
      |> DateTime.to_time()
      |> Time.to_iso8601()

    {_, interval_time_string} = System.fetch_env("INTERVAL_TIME")
    {interval_time, _} = Integer.parse(interval_time_string)

    Process.send_after(self(), :get_and_parse_job, interval_time)

    IO.puts("Get and Parse Job Executed - #{clock}")
    GamesController.get_and_parse()

    {:noreply, state}
  end

  @impl true
  def handle_info(:check_to_send_notification_to_users, state) do
    clock =
      DateTime.utc_now()
      |> DateTime.to_time()
      |> Time.to_iso8601()

    {_, interval_time_string} = System.fetch_env("INTERVAL_TIME")
    {interval_time, _} = Integer.parse(interval_time_string)

    Process.send_after(self(), :check_to_send_notification_to_users, interval_time + 10000)

    IO.puts("Check to Send Notification To Users Job Executed - #{clock}")
    NotificationController.notification_job()

    {:noreply, state}
  end
end
