defmodule InsigniaNotifyAppWeb.Shared.GameList.GameListComponent do
  use InsigniaNotifyAppWeb, :live_component

  alias InsigniaNotifyAppWeb.GamesController
  alias InsigniaNotifyAppWeb.Shared.GameList.GameListHeaderComponent
  alias InsigniaNotifyAppWeb.Shared.GameList.GameListContentComponent

  def render(assigns) do
    ~H"""
    <ul class="game-list lg:w-[1140px] w-full my-0 mx-auto px-4 lg:px-0">
      <%= for item <- @games do %>
        <li class="w-full flex flex-col bg-gray-700 rounded accordion overflow-hidden mb-5">
          <.live_component
            module={GameListHeaderComponent}
            id={"game_list_header_#{item.serial}"}
            content={item}
          />
          <.live_component
            module={GameListContentComponent}
            id={"game_list_content_#{item.serial}"}
            content={item}
          />
        </li>
      <% end %>
    </ul>
    """
  end

  def mount(socket) do
    if connected?(socket), do: tick()

    set_games(socket)
  end

  def update(%{action: :tick}, socket) do
    tick()

    set_games(socket)
  end

  def update(_assigns, socket) do
    {:ok, socket}
  end

  defp set_games(socket) do
    case GamesController.get_games() do
      {:ok, []} ->
        {
          :ok,
          socket
          |> assign(games: [])
        }

      {:ok, games} ->
        {:ok,
         socket
         |> assign(games: games)}
    end
  end

  defp tick() do
    {_, interval_time_string} = Application.get_env(:insignia_notify_app, :interval_time)
    {interval_time, _} = Integer.parse(interval_time_string)

    send_update_after(__MODULE__, %{id: :game_list, action: :tick}, interval_time + 1000)
  end
end
