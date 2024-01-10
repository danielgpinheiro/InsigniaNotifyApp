defmodule InsigniaNotifyAppWeb.Shared.GameList.GameListContentComponent do
  use InsigniaNotifyAppWeb, :live_component

  alias InsigniaNotifyAppWeb.GamesController
  alias InsigniaNotifyAppWeb.NotificationController

  def render(assigns) do
    ~H"""
    <div>
      <%= if @show_modal do %>
        <.modal show id="game-list-content-modal" on_cancel={JS.push("close-modal", target: @myself)}>
          <div>
            <h3 class="ml-5 text-white text-2xl font-chakra">
              <%= @content.name %>
            </h3>

            <%= if @content.has_matchmaking_feature or @content.serial === "MS-074" do %>
              <div class="w-full bg-gray-600 flex overflow-hidden flex-wrap lg:flex-nowrap">
                <%= if @content.serial !== "MS-074" do %>
                  <div class="w-full lg:w-[40%] flex-col">
                    <h3 class="font-chakra text-white text-lg p-5">Notifications</h3>

                    <form class="p-5 w-full flex-col">
                      <div class="flex justify-between mb-6">
                        <span class="font-base font-roboto text-gray-300">
                          Notify when have new sessions
                        </span>

                        <label class="slideon">
                          <input
                            disabled={!Map.has_key?(@matches, :head)}
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
                        <span class="font-base font-roboto text-gray-300">
                          Notify when sessions end
                        </span>

                        <label class="slideon">
                          <input
                            disabled={!Map.has_key?(@matches, :head)}
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
                    </form>
                  </div>
                <% end %>

                <div class="w-full lg:w-[60%] flex-col pb-2 lg:pb-0 relative">
                  <h3 class="font-chakra text-white text-lg p-5">
                    <%= if @content.serial === "MS-074", do: "Servers", else: "Matches" %>
                  </h3>

                  <%= if Map.has_key?(@matches, :head) do %>
                    <div class="max-h-[200px] overflow-y-scroll overflow-x-hidden relative pr-6 lg:pr-0">
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
                  <% end %>
                </div>
              </div>
            <% else %>
              <div />
            <% end %>
          </div>
        </.modal>
      <% end %>
    </div>
    """
  end

  def mount(socket) do
    {:ok,
     socket
     |> assign(content: %{})
     |> assign(matches: %{})
     |> assign(new_sessions: false)
     |> assign(end_sessions: false)
     |> assign(show_modal: false)}
  end

  def update(%{action: :content_opened, game_content: game_content}, socket) do
    user_id = socket.assigns.user_id
    url = game_content.url
    game_serial = game_content.serial

    matches =
      GamesController.get_game_matches(url)

    notification_params =
      case NotificationController.get_game_notification(%{
             user_id: user_id,
             game_serial: game_serial
           }) do
        {:ok, params} ->
          params

        {:error, _} ->
          %{
            new_sessions: false,
            end_sessions: false
          }
      end

    {:ok,
     socket
     |> assign(matches: matches)
     |> assign(new_sessions: notification_params.new_sessions)
     |> assign(end_sessions: notification_params.end_sessions)
     |> assign(content: game_content)
     |> assign(show_modal: true)}
  end

  def update(%{user_id: user_id, id: id} = _assigns, socket) do
    {:ok,
     socket
     |> assign(user_id: user_id)
     |> assign(id: id)}
  end

  def update(_, socket) do
    {:ok, socket}
  end

  def handle_event(
        "change-game-notifications",
        params,
        socket
      ) do
    user_id = socket.assigns.user_id
    target = Enum.at(Map.get(params, "_target"), 0)
    game_serial = socket.assigns.content.serial
    notification_name = String.replace(target, "-game_list_content", "")

    %{
      game_serial: game_serial,
      notification_name: notification_name,
      value: Map.get(params, target) == "on",
      user_id: user_id
    }
    |> NotificationController.set_game_notification()

    {:noreply, socket}
  end

  def handle_event("close-modal", _, socket) do
    {:noreply, socket |> assign(show_modal: false)}
  end
end
