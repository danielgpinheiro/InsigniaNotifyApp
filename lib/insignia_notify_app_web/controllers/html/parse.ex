defmodule InsigniaNotifyAppWeb.Html.Parse do
  def parse_games_row(row) do
    {_, _, tds} = row

    game_name =
      tds
      |> Floki.find("a:nth-child(2)")
      |> Floki.text()

    game_url =
      tds
      |> Floki.find("a:nth-child(2)")
      |> Floki.attribute("href")
      |> Enum.at(0)

    {serial, code} =
      tds
      |> Floki.find("td:nth-child(2)")
      |> Floki.text()
      |> String.split(" ")
      |> Enum.map(fn text -> String.replace(text, "\n", "") end)
      |> List.to_tuple()

    online_users =
      tds
      |> Floki.find("td:nth-child(3)")
      |> Floki.text()
      |> String.replace("\n", "")

    {active_players, active_sessions} =
      tds
      |> Floki.find("td:nth-child(4)")
      |> Floki.text()
      |> String.split("in")
      |> handle_active_players_content()

    %{
      name: game_name,
      url: game_url,
      serial: serial,
      code: code,
      online_users: String.to_integer(online_users),
      active_players: String.to_integer(active_players),
      active_sessions: String.to_integer(active_sessions)
    }
  end

  def parse_stats(html) do
    row =
      html
      |> Floki.find(".row")

    registered_users =
      row
      |> Floki.find("div:nth-child(2) h3")
      |> Floki.text()

    games_supported =
      row
      |> Floki.find("div:nth-child(3) h3")
      |> Floki.text()

    users_online_now =
      row
      |> Floki.find("div:nth-child(4) h3")
      |> Floki.text()

    %{
      registered_users: registered_users,
      games_supported: games_supported,
      users_online_now: users_online_now
    }
  end

  defp handle_active_players_content(list) when length(list) == 1 do
    active_players =
      list
      |> Enum.at(0)
      |> String.replace("\n", "")
      |> String.replace("-", "0")

    {active_players, "0"}
  end

  defp handle_active_players_content(list) when length(list) == 2 do
    active_players =
      list
      |> Enum.at(0)
      |> String.replace("\n", "")
      |> String.trim()

    active_sessions =
      list
      |> Enum.at(1)
      |> String.split("\n")
      |> Enum.at(0)
      |> String.trim()

    {active_players, active_sessions}
  end
end
