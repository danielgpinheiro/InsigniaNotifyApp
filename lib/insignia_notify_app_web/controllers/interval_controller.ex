defmodule InsigniaNotifyAppWeb.IntervalController do
  use GenServer, restart: :transient

  alias InsigniaNotifyAppWeb.GamesController

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  @impl true
  def init(opts) do
    IO.puts("InsigniaNotifyAppWeb.IntervalController init")

    {_, interval_time_string} = Application.get_env(:insignia_notify_app, :interval_time)

    {interval_time, _} = Integer.parse(interval_time_string)

    Process.send_after(self(), :get_and_parse_job, interval_time)
    Process.send_after(self(), :get_and_parse_after_ets_created, interval_time + 100)

    create_stats_table()

    {:ok, opts}
  end

  @impl true
  def handle_info(:get_and_parse_job, state) do
    clock =
      DateTime.utc_now()
      |> DateTime.to_time()
      |> Time.to_iso8601()

    {_, interval_time_string} = Application.get_env(:insignia_notify_app, :interval_time)

    {interval_time, _} = Integer.parse(interval_time_string)

    IO.puts("Get and Parse Job Executed - #{clock}")

    GamesController.get_and_parse()

    Process.send_after(self(), :get_and_parse_job, interval_time)

    {:noreply, state}
  end

  @impl true
  def handle_info(:get_and_parse_after_ets_created, state) do
    GamesController.get_and_parse()

    {:noreply, state}
  end

  def create_stats_table do
    :ets.new(:stats, [:set, :named_table])
  end
end
