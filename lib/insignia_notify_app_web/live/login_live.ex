defmodule InsigniaNotifyAppWeb.LoginLive do
  use InsigniaNotifyAppWeb, :live_view

  def render(assigns) do
    ~H"""
    <section
      phx-hook="RequestNotification"
      id="login"
      class="w-full h-[100vh] relative flex justify-center items-center"
    >
      <%= if @loading do %>
        <img src="/images/loading.svg" class="w-20" />
      <% end %>

      <%= if Map.get(@permissions, "permission") != "granted" and @loading == false do %>
        <div class="p-2">
          <div class="w-full lg:w-[300px] bg-[#fff4e5] rounded text-[#000]">
            <%= if Map.get(@permissions, "isIOSButNotInstalled") do %>
              <div class="pb-4 px-3 pt-3">
                <strong class="font-chakra">iOS install required</strong>
                <br />
                <span class="font-chakra">
                  Click on the Share icon and Add to Home Screen to enable notifications on iOS
                </span>
              </div>
            <% end %>

            <%= if Map.get(@permissions, "permission") == "default" and !Map.get(@permissions, "isIOSButNotInstalled") do %>
              <div class="p-3 flex flex-col">
                <strong class="font-chakra">Notifications are disabled</strong>
                <span class="font-chakra">
                  Grant your browser permission to display notifications
                </span>
                <small class="font-chakra mt-2 mb-4">
                  Insignia Notify needs notification permission to save your preferences
                </small>

                <br />

                <button
                  class="font-chakra font-bold self-center p-2 rounded bg-gray-50 border-[1px] border-gray-500"
                  phx-click={JS.dispatch("requestNotificationPermission")}
                >
                  Grant Now
                </button>
              </div>
            <% end %>
          </div>
        </div>
      <% end %>
    </section>
    """
  end

  def mount(_, _, socket) do
    if connected?(socket), do: send(self(), :get_notification_permission)

    {:ok, socket |> assign(permissions: %{}) |> assign(loading: true)}
  end

  def handle_info(:get_notification_permission, socket) do
    {:noreply, push_event(socket, "getNotificationPermission", %{})}
  end

  def handle_event("notification-permissions", permissions, socket) do
    permission = Map.get(permissions, "permission")

    case permission do
      "granted" -> {:noreply, push_event(socket, "generateFirebaseToken", %{})}
      _ -> {:noreply, socket |> assign(permissions: permissions) |> assign(loading: false)}
    end
  end

  def handle_event("fbTokenCreated", _, socket) do
    {:noreply, push_navigate(socket, to: ~p"/games", replace: true)}
  end
end
