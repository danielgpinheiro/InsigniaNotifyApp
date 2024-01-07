defmodule InsigniaNotifyAppWeb.Shared.GameList.GameListComponent do
  @moduledoc false

  use InsigniaNotifyAppWeb, :live_component

  alias InsigniaNotifyAppWeb.GamesController
  alias InsigniaNotifyAppWeb.FilterController
  alias InsigniaNotifyAppWeb.Shared.GameList.GameListHeaderComponent
  alias InsigniaNotifyAppWeb.Shared.GameList.GameListContentComponent

  def render(assigns) do
    ~H"""
    <ul
      class="game-list w-full lg:w-11/12 max-w-[1140px] my-0 mx-auto px-4 lg:px-0 min-h-[500px]"
      id="list"
      phx-hook="Accordion"
    >
      <%= if length(@games) > 0 do %>
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
              user_id={@user_id}
            />
          </li>
        <% end %>
      <% else %>
        <h1 class="text-white text-2xl  font-chakra text-center py-10">
          No games found with this filter
        </h1>
      <% end %>
    </ul>
    """
  end

  def mount(socket) do
    if connected?(socket), do: tick()

    {:ok, socket |> assign(filter: "") |> assign(games: get_games("", ""))}
  end

  def update(%{action: :filter_game_list, filter: filter}, socket) do
    user_id = socket.assigns.user_id

    {:ok, socket |> assign(filter: filter) |> assign(games: get_games(user_id, filter))}
  end

  def update(%{action: :order_by_game_list}, socket) do
    user_id = socket.assigns.user_id
    filter = socket.assigns.filter

    {:ok, socket |> assign(games: get_games(user_id, filter))}
  end

  def update(%{action: :tick}, socket) do
    tick()

    user_id = socket.assigns.user_id
    filter = socket.assigns.filter

    {:ok, socket |> assign(games: get_games(user_id, filter))}
  end

  def update(
        %{user_id: user_id} = _assigns,
        socket
      ) do
    filter = socket.assigns.filter

    {:ok,
     socket
     |> assign(user_id: user_id)
     |> assign(games: get_games(user_id, filter))}
  end

  def update(_assigns, socket) do
    {:ok, socket}
  end

  defp get_games(user_id, filter) do
    games = GamesController.get_games()

    {_, order_by_preferences_by_user_id} =
      if user_id != "",
        do: FilterController.get_order_by_preferences_by_user_id(user_id),
        else: {:ok, %{order_by: "active_users"}}

    filtered_games =
      if String.length(filter) > 0,
        do:
          Enum.filter(games, fn game ->
            name_downcased = String.downcase(game.name)
            serial_downcased = String.downcase(game.serial)
            code_downcased = String.downcase(game.code)
            filter_downcased = String.downcase(filter)

            String.contains?(name_downcased, filter_downcased) or
              String.contains?(serial_downcased, filter_downcased) or
              String.contains?(code_downcased, filter_downcased)
          end),
        else: games

    Enum.sort_by(
      filtered_games,
      &Map.fetch(&1, get_order_by_params(order_by_preferences_by_user_id).order_by),
      get_order_by_params(order_by_preferences_by_user_id).sorter
    )
  end

  defp get_order_by_params(order_by_preferences_by_user_id) do
    order_by_params =
      if order_by_preferences_by_user_id == :not_found,
        do: "active_users",
        else: order_by_preferences_by_user_id.order_by

    case order_by_params do
      "active_users" ->
        %{order_by: String.to_atom(order_by_params), sorter: :desc}

      "active_sessions" ->
        %{order_by: String.to_atom(order_by_params), sorter: :desc}

      "online_users" ->
        %{order_by: String.to_atom(order_by_params), sorter: :desc}

      "game_title" ->
        %{order_by: :name, sorter: :asc}
    end
  end

  defp tick() do
    {_, interval_time_string} = System.fetch_env("INTERVAL_TIME")
    {interval_time, _} = Integer.parse(interval_time_string)

    send_update_after(__MODULE__, %{id: :game_list, action: :tick}, interval_time + 1000)
  end
end
