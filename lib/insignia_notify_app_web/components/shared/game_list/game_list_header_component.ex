defmodule InsigniaNotifyAppWeb.Shared.GameList.GameListHeaderComponent do
  use InsigniaNotifyAppWeb, :live_component

  alias InsigniaNotifyAppWeb.Shared.GameList.GameListContentComponent

  def render(assigns) do
    ~H"""
    <div class="w-full flex relative p-1 flex-wrap lg:flex-nowrap">
      <div class="flex">
        <object data={@content.thumbnail} class="w-16 h-16 lg:w-24 lg:h-24 rounded" type="image/png">
          <img src="/images/logo.png" alt="" />
        </object>

        <div class="game-info flex flex-col lg:ml-6 ml-2 justify-center w-[275px] shrink-0">
          <a
            href={@content.url}
            target="_blank"
            class="text-white text-base font-chakra truncate lg:text-clip w-[80%] lg:w-auto"
          >
            <%= @content.name %>
          </a>

          <strong class="text-gray-300 text-sm"><%= @content.serial %></strong>
          <span class="text-gray-300 text-sm"><%= @content.code %></span>
        </div>
      </div>

      <div class="stats flex space-between items-center w-full lg:w-[35%] shrink-0 pr-10 lg:pr-0 mt-4 lg:mt-0">
        <strong class="text-white text-sm flex flex-col text-center font-chakra relative px-6 after:content-['*'] after:absolute after:top-[calc(50%-2px)] after:right-0 after:w-[5px] after:h-[5px] last:after:hidden">
          Online Users <span class="text-gray-300 text-base"><%= @content.online_users %></span>
        </strong>

        <strong class="text-white text-sm flex flex-col text-center font-chakra relative px-6 after:content-['*'] after:absolute after:top-[calc(50%-2px)] after:right-0 after:w-[5px] after:h-[5px] last:after:hidden">
          Active Users
          <span class="text-gray-300 text-base">
            <%= if @content.has_matchmaking_feature, do: @content.active_users, else: "-" %>
          </span>
        </strong>

        <strong class="text-white text-sm flex flex-col text-center font-chakra relative px-6 after:content-['*'] after:absolute after:top-[calc(50%-2px)] after:right-0 after:w-[5px] after:h-[5px] last:after:hidden">
          Active Sessions
          <span class="text-gray-300 text-base">
            <%= if @content.has_matchmaking_feature, do: @content.active_sessions, else: "-" %>
          </span>
        </strong>
      </div>

      <div class="features flex flex-col justify-center w-full lg:w-[20%] my-4 lg:my-0">
        <strong class="text-white font-chakra mb-2 pl-2">Features</strong>

        <div class="flex w-full justify-around">
          <i
            class={
              if @content.has_live_aware_feature,
                do: "material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer",
                else:
                  "material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer disabled"
            }
            data-tippy-content="Xbox Live Aware"
          >
            person
          </i>
          <i
            class={
              if @content.has_matchmaking_feature,
                do: "material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer",
                else:
                  "material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer disabled"
            }
            data-tippy-content="Matchmaking"
          >
            language
          </i>
          <i
            class={
              if @content.has_leaderboards_feature,
                do: "material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer",
                else:
                  "material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer disabled"
            }
            data-tippy-content="Leaderboards"
          >
            leaderboard
          </i>
          <i
            class={
              if @content.has_user_generated_content_feature,
                do: "material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer",
                else:
                  "material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer disabled"
            }
            data-tippy-content="User Generated Content"
          >
            extension
          </i>
        </div>
      </div>

      <%= if @content.has_matchmaking_feature or @content.serial === "MS-074" do %>
        <button
          class="absolute top-[calc(50%-20px)] right-4 bg-gray-800 rounded w-[40px] h-[40px] flex justify-center items-center"
          title="Expand to toggle notifications and view matches"
          phx-click="show_modal"
          phx-target={@myself}
          phx-value={false}
          id={"#{@id}_button"}
        >
          <span class="material-symbols-rounded !text-2xl text-white expand-more">
            page_info
          </span>
        </button>
      <% end %>
    </div>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{content: content, id: id} = _assigns, socket) do
    {:ok, socket |> assign(content: content) |> assign(id: id)}
  end

  def update(_, socket) do
    {:ok, socket}
  end

  def handle_event(
        "show_modal",
        _,
        socket
      ) do
    content = socket.assigns.content

    send_update(
      GameListContentComponent,
      %{id: :game_list_content, action: :content_opened, game_content: content}
    )

    {:noreply, socket}
  end
end
