defmodule InsigniaNotifyAppWeb.Shared.GameList.GameListComponent do
  use Phoenix.LiveComponent

  alias InsigniaNotifyAppWeb.Shared.GameList.GameListHeaderComponent
  alias InsigniaNotifyAppWeb.Shared.GameList.GameListContentComponent

  def render(assigns) do
    ~H"""
    <ul class="game-list lg:w-[1140px] w-full my-0 mx-auto px-4 lg:px-0">
      <%= for item <- 1..100 do %>
        <li class="w-full flex flex-col bg-gray-700 rounded accordion overflow-hidden mb-5">
          <.live_component module={GameListHeaderComponent} id={"game_list_header_#{item}"} />
          <.live_component module={GameListContentComponent} id={"game_list_content_#{item}"} />
        </li>
      <% end %>
    </ul>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end
end
