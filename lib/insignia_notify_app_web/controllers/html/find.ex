defmodule InsigniaNotifyAppWeb.Html.Find do
  alias InsigniaNotifyAppWeb.Http.HandleResponse
  alias InsigniaNotifyAppWeb.Html.Parse

  def find_games_row({:ok, html}, games_table_rows_selector) do
    Floki.find(html, games_table_rows_selector)
    |> Enum.map(fn row -> Parse.parse_games_row(row) end)
    |> IO.inspect()
  end

  def find_games_row({:error, reason}, _),
    do: HandleResponse.response(:error, reason)

  def find_insignia_stats({:ok, html}, stats_selector) do
    Floki.find(html, stats_selector)
    |> Parse.parse_stats()
  end

  def find_insignia_stats({:error, reason}, _),
    do: HandleResponse.response(:error, reason)
end
