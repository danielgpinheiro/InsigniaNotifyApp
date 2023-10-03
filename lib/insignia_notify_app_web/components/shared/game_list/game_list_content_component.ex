defmodule InsigniaNotifyAppWeb.Shared.GameList.GameListContentComponent do
  use InsigniaNotifyAppWeb, :live_component

  alias InsigniaNotifyAppWeb.GamesController

  def render(assigns) do
    ~H"""
    <div class="w-full bg-gray-600 flex overflow-hidden transition-[max-height] ease-out max-h-0 will-change-[max-height] accordion-content flex-wrap lg:flex-nowrap">
      <div class="w-full lg:w-[40%] flex-col">
        <h3 class="font-chakra text-white text-lg p-5">Notifications</h3>

        <form class="p-5 w-full flex-col">
          <div class="flex justify-between mb-6">
            <span class="font-base font-roboto text-gray-300">Notify when have new sessions</span>

            <label class="slideon">
              <input type="checkbox" class="slideon slideon-auto slideon-success" />
              <span class="slideon-slider"></span>
            </label>
          </div>

          <div class="flex justify-between mb-6">
            <span class="font-base font-roboto text-gray-300">Notify when sessions end</span>

            <label class="slideon">
              <input type="checkbox" class="slideon slideon-auto slideon-success" />
              <span class="slideon-slider"></span>
            </label>
          </div>

          <div class="flex justify-between mb-6">
            <span class="font-base font-roboto text-gray-300">
              Notify when sessions have new players
            </span>

            <label class="slideon">
              <input type="checkbox" class="slideon slideon-auto slideon-success" />
              <span class="slideon-slider"></span>
            </label>
          </div>

          <div class="flex justify-between mb-6">
            <span class="font-base font-roboto text-gray-300">
              Notify when sessions have fewer players
            </span>

            <label class="slideon">
              <input type="checkbox" class="slideon slideon-auto slideon-success" />
              <span class="slideon-slider"></span>
            </label>
          </div>
        </form>
      </div>

      <div class="w-full lg:w-[60%] flex-col pb-2 lg:pb-0 relative">
        <h3 class="font-chakra text-white text-lg p-5">Matches</h3>

        <%= if Map.has_key?(@matches, :head) do %>
          <div class="max-h-[200px] overflow-y-auto overflow-x-hidden relative">
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
    {:ok, socket |> assign(matches: %{})}
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

  def update(%{current_user: current_user, content: content} = _assigns, socket) do
    {:ok,
     socket
     |> assign(current_user: current_user)
     |> assign(content: content)}
  end

  def update(_, socket) do
    {:ok, socket}
  end
end
