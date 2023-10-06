defmodule InsigniaNotifyAppWeb.Shared.GameList.GameListContentComponent do
  use InsigniaNotifyAppWeb, :live_component

  alias InsigniaNotifyAppWeb.GamesController
  alias InsigniaNotifyAppWeb.NotificationController

  def render(assigns) do
    ~H"""
    <div class="w-full bg-gray-600 flex overflow-hidden transition-[max-height] ease-out max-h-0 accordion-content flex-wrap lg:flex-nowrap">
      <div class="w-full lg:w-[40%] flex-col">
        <h3 class="font-chakra text-white text-lg p-5">Notifications</h3>

        <form class="p-5 w-full flex-col">
          <div class="flex justify-between mb-6">
            <span class="font-base font-roboto text-gray-300">Notify when have new sessions</span>

            <label class="slideon">
              <input
                id={"new_sessions-#{@id}"}
                type="checkbox"
                name={"new_sessions-#{@id}"}
                value={@new_sessions}
                checked={@new_sessions}
                phx-change="change-game-notifications"
                phx-target={@myself}
                class="slideon slideon-auto slideon-success"
              />
              <span class="slideon-slider"></span>
            </label>
          </div>

          <div class="flex justify-between mb-6">
            <span class="font-base font-roboto text-gray-300">Notify when sessions end</span>

            <label class="slideon">
              <input
                id={"end_sessions-#{@id}"}
                type="checkbox"
                name={"end_sessions-#{@id}"}
                checked={@end_sessions}
                phx-change="change-game-notifications"
                phx-target={@myself}
                class="slideon slideon-auto slideon-success"
              />
              <span class="slideon-slider"></span>
            </label>
          </div>

          <div class="flex justify-between mb-6 opacity-0 pointer-events-none">
            <span class="font-base font-roboto text-gray-300">
              Notify when sessions have new players
            </span>

            <label class="slideon">
              <input
                id={"new_players-#{@id}"}
                type="checkbox"
                name={"new_players-#{@id}"}
                checked={@new_players}
                phx-change="change-game-notifications"
                phx-target={@myself}
                class="slideon slideon-auto slideon-success"
              />
              <span class="slideon-slider"></span>
            </label>
          </div>

          <div class="flex justify-between mb-6 opacity-0 pointer-events-none">
            <span class="font-base font-roboto text-gray-300">
              Notify when sessions have fewer players
            </span>

            <label class="slideon">
              <input
                id={"fewer_players-#{@id}"}
                type="checkbox"
                name={"fewer_players-#{@id}"}
                checked={@fewer_players}
                phx-change="change-game-notifications"
                phx-target={@myself}
                class="slideon slideon-auto slideon-success"
              />
              <span class="slideon-slider"></span>
            </label>
          </div>
        </form>
      </div>

      <div class="w-full lg:w-[60%] flex-col pb-2 lg:pb-0 relative min-h-[200px]">
        <h3 class="font-chakra text-white text-lg p-5">Matches</h3>

        <%= if Map.has_key?(@matches, :head) do %>
          <div class="max-h-[200px] overflow-y-auto overflow-x-hidden relative pr-6 lg:pr-0">
            <ul class="table border-collapse table-fixed w-full ml-5">
              <li class="table-row">
                <%= for head <- @matches.head do %>
                  <div class="table-cell">
                    <strong class="text-white font-chakra"><%= head %></strong>
                  </div>
                <% end %>
              </li>

              <%= for body <- @matches.body do %>
                <li class="table-row">
                  <%= for text <- body do %>
                    <div class="table-cell text-white"><%= text %></div>
                  <% end %>
                </li>
              <% end %>
            </ul>
          </div>
        <% else %>
          <img
            src="/images/loading.svg"
            class="absolute w-[60px] top-[calc(50%-30px)] left-[calc(50%-30px)] "
          />
        <% end %>
      </div>
    </div>
    """
  end

  def mount(socket) do
    {:ok,
     socket
     |> assign(matches: %{})
     |> assign(new_sessions: false)
     |> assign(end_sessions: false)
     |> assign(new_players: false)
     |> assign(fewer_players: false)}
  end

  def update(%{action: :content_opened, opened: opened}, socket) do
    url = socket.assigns.content.url

    if opened do
      matches =
        GamesController.get_game_matches(url)

      {:ok, socket |> assign(matches: matches)}
    else
      {:ok, socket |> assign(matches: %{})}
    end
  end

  def update(%{current_user: current_user, content: content, id: id} = _assigns, socket) do
    case NotificationController.get_game_notification(%{
           user_id: current_user.id,
           game_serial: String.replace(id, "game_list_content_", "")
         }) do
      {:ok, params} ->
        {:ok,
         socket
         |> assign(current_user: current_user)
         |> assign(content: content)
         |> assign(id: id)
         |> assign(new_sessions: params.new_sessions)
         |> assign(end_sessions: params.end_sessions)
         |> assign(new_players: params.new_players)
         |> assign(fewer_players: params.fewer_players)}

      {:error, _} ->
        {:ok,
         socket
         |> assign(current_user: current_user)
         |> assign(content: content)
         |> assign(id: id)}
    end
  end

  def update(_, socket) do
    {:ok, socket}
  end

  def handle_event(
        "change-game-notifications",
        params,
        socket
      ) do
    user_id = socket.assigns.current_user.id
    target = Enum.at(Map.get(params, "_target"), 0)
    notification_name = String.replace(target, "-#{socket.assigns.id}", "")

    %{
      game_serial: String.replace(socket.assigns.id, "game_list_content_", ""),
      notification_name: notification_name,
      value: Map.get(params, target) == "on",
      user_id: user_id
    }
    |> NotificationController.set_game_notification()

    {:noreply, socket}
  end
end
