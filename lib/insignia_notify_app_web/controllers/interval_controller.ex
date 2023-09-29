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

    Process.send_after(self(), :tick, interval_time)

    GamesController.get_and_parse()

    {:ok, opts}
  end

  @impl true
  def handle_info(:tick, state) do
    clock =
      DateTime.utc_now()
      |> DateTime.to_time()
      |> Time.to_iso8601()

    {_, interval_time_string} = Application.get_env(:insignia_notify_app, :interval_time)

    {interval_time, _} = Integer.parse(interval_time_string)

    IO.puts("Tick - #{clock}")

    GamesController.get_and_parse()

    Process.send_after(self(), :tick, interval_time)

    {:noreply, state}
  end
end
