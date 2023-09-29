defmodule InsigniaNotifyAppWeb.GamesController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyApp.Stats

  alias InsigniaNotifyAppWeb.Html.Find
  alias InsigniaNotifyAppWeb.Http.GetInsigniaData

  def get_and_parse do
    {_, base_url} = Application.get_env(:insignia_notify_app, :base_url)

    GetInsigniaData.get(base_url)
    |> parse_document()
  end

  defp parse_document({:ok, body}) do
    {_, games_table_rows_selector} =
      Application.get_env(:insignia_notify_app, :games_table_rows_selector)

    {_, stats_selector} = Application.get_env(:insignia_notify_app, :stats_selector)

    document = Floki.parse_document(body)

    # Find.find_games_row(document, Application.get_env(:insignia_notify_app, games_table_rows_selector))
    Find.find_insignia_stats(document, stats_selector)
    |> update_stats()

    {:ok}
  end

  defp update_stats(params) do
    params = params |> Map.put(:id, 1)

    case Stats.get() do
      {:error, :not_found} ->
        Stats.create(params)

      {:ok, stats} ->
        Stats.update(stats, params)
    end
  end

  def get_stats() do
    Stats.get()
  end
end
