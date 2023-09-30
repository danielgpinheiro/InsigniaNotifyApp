defmodule InsigniaNotifyAppWeb.GamesController do
  use InsigniaNotifyAppWeb, :controller

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

  defp parse_document({:ok, body}) do
    # {_, games_table_rows_selector} =
    #   Application.get_env(:insignia_notify_app, :games_table_rows_selector)

    {_, stats_selector} = Application.get_env(:insignia_notify_app, :stats_selector)

    document = Floki.parse_document(body)

    # Find.find_games_row(document, Application.get_env(:insignia_notify_app, games_table_rows_selector))
    Find.find_insignia_stats(document, stats_selector)
    |> update_stats()

    {:ok}
  end

  defp parse_document({:error, reason}) do
    IO.puts("ERROR Parse Document")
    IO.warn(reason)
  end

  defp update_stats(params) do
    games_supported = params.games_supported
    registered_users = params.registered_users
    users_online_now = params.users_online_now

    :ets.insert(:stats, {:games_supported, games_supported})
    :ets.insert(:stats, {:registered_users, registered_users})
    :ets.insert(:stats, {:users_online_now, users_online_now})
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
end
