defmodule InsigniaNotifyAppWeb.GamesController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyAppWeb.Html.Find
  alias InsigniaNotifyAppWeb.Http.Api
  alias InsigniaNotifyAppWeb.Http.GetInsigniaData

  def init do
    :ets.new(:stats, [:set, :named_table])
    :ets.new(:games, [:set, :named_table])

    get_and_parse()
  end

  def get_and_parse do
    {_, base_url} = System.fetch_env("BASE_URL")

    GetInsigniaData.get(base_url)
    |> parse_document()
  end

  def get_stats() do
    list = :ets.tab2list(:stats)

    if length(list) > 0 do
      games_supported =
        list
        |> Enum.at(0)
        |> elem(1)

      registered_users =
        list
        |> Enum.at(1)
        |> elem(1)

      users_online_now =
        list
        |> Enum.at(2)
        |> elem(1)

      {:ok,
       %{
         games_supported: games_supported,
         registered_users: registered_users,
         users_online_now: users_online_now
       }}
    else
      {:error, :not_found}
    end
  end

  def get_games do
    list = :ets.tab2list(:games)

    if length(list) > 0 do
      {_, games} = list |> Enum.at(0)
      games
    else
      []
    end
  end

  def get_game_matches(url) do
    case Api.get(url) do
      {:ok, body} ->
        document = Floki.parse_document(body)

        Find.find_game_matches(
          document,
          "table"
        )

      {:error, _} ->
        {:error, :internal_server_error}
    end
  end

  def get_games_api(conn, _params) do
    games = get_games()

    conn
    |> put_status(:ok)
    |> json(%{games: games})
  end

  defp parse_document({:ok, body}) do
    {_, games_table_rows_selector} =
      System.fetch_env("TABLE_ROWS_SELECTOR")

    {_, stats_selector} = System.fetch_env("STATS_SELECTOR")

    document = Floki.parse_document(body)

    Find.find_games_row(
      document,
      games_table_rows_selector
    )
    |> update_game()

    Find.find_insignia_stats(document, stats_selector)
    |> update_stats()

    {:ok}
  end

  defp parse_document({:error, reason}) do
    IO.puts("ERROR Parse Document")
    IO.warn(reason)
  end

  defp update_game(games) do
    cached_games = get_games()

    updated_games =
      Enum.map(games, fn game ->
        filtered_game =
          Enum.find(cached_games, fn cached_game -> game.serial == cached_game.serial end)

        if filtered_game != nil do
          last_active_users =
            if Map.has_key?(filtered_game, :active_users), do: filtered_game.active_users, else: 0

          last_active_sessions =
            if Map.has_key?(filtered_game, :active_sessions),
              do: filtered_game.active_sessions,
              else: 0

          game
          |> Map.put(:last_active_users, last_active_users)
          |> Map.put(:last_active_sessions, last_active_sessions)
        else
          game
          |> Map.put(:last_active_users, 0)
          |> Map.put(:last_active_sessions, 0)
        end
      end)

    :ets.insert(:games, {:games_list, updated_games})
  end

  defp update_stats(stats) do
    games_supported = stats.games_supported
    registered_users = stats.registered_users
    users_online_now = stats.users_online_now

    :ets.insert(:stats, {:games_supported, games_supported})
    :ets.insert(:stats, {:registered_users, registered_users})
    :ets.insert(:stats, {:users_online_now, users_online_now})
  end
end
