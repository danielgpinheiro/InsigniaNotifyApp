defmodule InsigniaNotifyAppWeb.FeedController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyAppWeb.GamesController
  alias Atomex.{Feed, Entry}

  @author "Daniel Pinheiro"
  @email "dedelabritos@gmail.com"

  def index(conn, _params) do
    games = GamesController.get_games()
    feed = build_feed(games, conn)

    conn
    |> put_resp_content_type("text/xml")
    |> send_resp(200, feed)
  end

  defp build_feed(posts, conn) do
    Feed.new(Routes.home_index_url(conn, :index), DateTime.utc_now(), "FullstackPhoenix RSS")
    |> Feed.author(@author, email: @email)
    |> Feed.link(Routes.rss_url(conn, :index), rel: "self")
    |> Feed.entries(Enum.map(posts, &get_entry(conn, &1)))
    |> Feed.build()
    |> Atomex.generate_document()
  end

  defp get_entry(conn, %{name: name}) do
    Entry.new(Routes.post_url(conn, :show), name)
    |> Entry.link(Routes.post_url(conn, :show))
    |> Entry.author(@author)
    |> Entry.content(name, type: "text")
    |> Entry.build()
  end
end
