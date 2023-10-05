defmodule InsigniaNotifyAppWeb.IntervalController do
  use GenServer, restart: :transient

  alias InsigniaNotifyAppWeb.GamesController

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  @impl true
  def init(opts) do
    IO.puts("InsigniaNotifyAppWeb.IntervalController init")

    {_, interval_time_string} = System.fetch_env("INTERVAL_TIME")
    {interval_time, _} = Integer.parse(interval_time_string)

    Process.send_after(self(), :get_and_parse_job, interval_time)

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
end
