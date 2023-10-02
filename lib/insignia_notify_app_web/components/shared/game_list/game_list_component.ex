defmodule InsigniaNotifyAppWeb.Shared.GameList.GameListComponent do
  @moduledoc false

  use InsigniaNotifyAppWeb, :live_component

  alias InsigniaNotifyAppWeb.GamesController
  alias InsigniaNotifyAppWeb.FilterController
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

    {:ok, socket |> assign(games: get_games(""))}
  end

  def update(%{action: :order_by_game_list}, socket) do
    user_id = socket.assigns.current_user.id

    {:ok, socket |> assign(games: get_games(user_id))}
  end

  def update(%{action: :tick}, socket) do
    tick()

    user_id = socket.assigns.current_user.id

    {:ok, socket |> assign(games: get_games(user_id))}
  end

  def update(%{current_user: current_user} = _assigns, socket) do
    {:ok,
     socket |> assign(current_user: current_user) |> assign(games: get_games(current_user.id))}
  end

  def update(_assigns, socket) do
    {:ok, socket}
  end

  defp get_games(user_id) do
    {_, games} = GamesController.get_games()

    {_, order_by_preferences_by_user_id} =
      if user_id != "",
        do: FilterController.get_order_by_preferences_by_user_id(user_id),
        else: {:ok, %{order_by: "active_users"}}

    Enum.sort_by(
      games,
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
    {_, interval_time_string} = Application.get_env(:insignia_notify_app, :interval_time)
    {interval_time, _} = Integer.parse(interval_time_string)

    send_update_after(__MODULE__, %{id: :game_list, action: :tick}, interval_time + 1000)
  end
end
