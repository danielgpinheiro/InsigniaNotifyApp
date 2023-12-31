defmodule InsigniaNotifyAppWeb.Shared.Filter.FilterComponent do
  @moduledoc false

  use InsigniaNotifyAppWeb, :live_component

  alias InsigniaNotifyApp.Filters.Filter

  alias InsigniaNotifyAppWeb.GamesController
  alias InsigniaNotifyAppWeb.FilterController
  alias InsigniaNotifyAppWeb.Shared.GameList.GameListComponent
  alias InsigniaNotifyAppWeb.Shared.Filter.FormComponent

  def render(assigns) do
    ~H"""
    <div class="flex flex-col xl:w-[1140px] w-full mt-20 xl:mt-24 mb-5 mx-auto px-4 xl:px-0">
      <.live_component module={FormComponent} id={:form} />

      <div class="flex items-center justify-between lg:flex-row flex-col">
        <div class="lg:mb-0 mb-6 text-center">
          <span class="text-gray-300 font-chakra mr-2 lg:mr-5 lg:ml-0">
            <strong><%= @registered_users %></strong> Registered Users
          </span>
          <span class="text-gray-300 font-chakra ml-2 lg:mr-5 lg:ml-0">
            <strong><%= @users_online_now %></strong> Users Online Now
          </span>

          <br class="lg:hidden" />

          <span class="text-gray-300 font-chakra">
            <strong><%= @games_supported %></strong> Games Supported
          </span>
        </div>

        <form class="flex item-center text-white font-chakra rounded bg-gray-700 relative">
          <.input
            id="order-by-preferences"
            type="select"
            options={[
              "Order by Active Users": "active_users",
              "Order by Active Sessions": "active_sessions",
              "Order by Online Users": "online_users",
              "Order by Game Title": "game_title"
            ]}
            name="order-by-preferences"
            value={@order_by}
            phx-change="change-order-by"
            phx-target={@myself}
          >
          </.input>
        </form>
      </div>
    </div>
    """
  end

  def mount(socket) do
    if connected?(socket), do: tick()
    update_stats(socket)
  end

  def update(%{action: :tick}, socket) do
    tick()

    update_stats(socket)
  end

  def update(%{user_id: user_id} = _assigns, socket) do
    case FilterController.get_order_by_preferences_by_user_id(user_id) do
      {:ok, %Filter{order_by: order_by}} ->
        {
          :ok,
          socket
          |> assign(:user_id, user_id)
          |> assign(:order_by, order_by)
        }

      {:error, _} ->
        {:ok,
         socket
         |> assign(:user_id, user_id)
         |> assign(:order_by, "active_users")}
    end
  end

  def update_stats(socket) do
    case GamesController.get_stats() do
      {:ok,
       %{
         registered_users: registered_users,
         games_supported: games_supported,
         users_online_now: users_online_now
       }} ->
        {
          :ok,
          socket
          |> assign(registered_users: registered_users)
          |> assign(games_supported: games_supported)
          |> assign(users_online_now: users_online_now)
        }

      {:error, _} ->
        {:ok,
         socket
         |> assign(registered_users: "-")
         |> assign(games_supported: "-")
         |> assign(users_online_now: "-")}
    end
  end

  def handle_event(
        "change-order-by",
        %{"_target" => ["order-by-preferences"], "order-by-preferences" => order_by},
        socket
      ) do
    user_id = socket.assigns.user_id
    FilterController.change_order_by(%{user_id: user_id, order_by: order_by})

    send_update(GameListComponent, %{
      id: :game_list,
      action: :order_by_game_list
    })

    {:noreply, socket |> assign(:order_by, order_by)}
  end

  defp tick() do
    {_, interval_time_string} = System.fetch_env("INTERVAL_TIME")
    {interval_time, _} = Integer.parse(interval_time_string)

    send_update_after(__MODULE__, %{id: :filter_form, action: :tick}, interval_time + 1000)
  end
end
