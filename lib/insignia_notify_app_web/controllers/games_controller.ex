defmodule InsigniaNotifyAppWeb.GamesController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyApp.Games

  alias InsigniaNotifyAppWeb.Html.Find
  alias InsigniaNotifyAppWeb.Http.GetInsigniaData

  def init do
    :ets.new(:stats, [:set, :named_table])

    get_and_parse()
  end

  def get_and_parse do
    {_, base_url} = Application.get_env(:insignia_notify_app, :base_url)

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
    Games.get_all()
  end

  defp parse_document({:ok, body}) do
    {_, games_table_rows_selector} =
      Application.get_env(:insignia_notify_app, :games_table_rows_selector)

    {_, stats_selector} = Application.get_env(:insignia_notify_app, :stats_selector)

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
    Enum.map(games, fn game ->
      case Games.get(game.serial) do
        {:ok, _} ->
          {_, copy_game} = Games.get(game.serial)

          last_active_users =
            if Map.has_key?(copy_game, :active_users), do: copy_game.active_users, else: 0

          last_active_sessions =
            if Map.has_key?(copy_game, :active_sessions), do: copy_game.active_sessions, else: 0

          modified_game =
            game
            |> Map.put(:last_active_users, last_active_users)
            |> Map.put(:last_active_sessions, last_active_sessions)

          Games.update(copy_game, modified_game)

        {:error, _} ->
          game
          |> Map.put(:last_active_users, 0)
          |> Map.put(:last_active_sessions, 0)
          |> Games.create()
      end
    end)
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
