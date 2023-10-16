defmodule InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent do
  use InsigniaNotifyAppWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="fixed bottom-10 lg:bottom-0 right-0 z-10">
      <%= if Map.get(@notification_params, "permission") != "granted" do %>
        <div class=" p-2">
          <div class="w-full lg:w-[300px] bg-[#fff4e5] rounded text-[#000]">
            <%= if Map.get(@notification_params, "isIOSButNotInstalled") do %>
              <div class="pb-4 px-3 pt-3">
                <strong class="font-chakra">iOS install required</strong>
                <br />
                <span class="font-chakra">
                  Click on the Share icon and Add to Home Screen to enable notifications on iOS
                </span>
              </div>
            <% end %>

            <%= if Map.get(@notification_params, "permission") == "default" and !Map.get(@notification_params, "isIOSButNotInstalled") do %>
              <div class="pb-10 px-3 pt-3">
                <strong class="font-chakra">Notifications are disabled</strong>
                <br />
                <span class="font-chakra">
                  Grant your browser permission to display desktop notifications
                </span>

                <br />

                <button
                  class="font-chakra font-bold absolute bottom-5 right-6"
                  phx-click={JS.dispatch("requestNotificationPermission")}
                >
                  Grant Now
                </button>
              </div>
            <% end %>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  def update(%{notification_params: params} = _assigns, socket) do
    socket =
      socket
      |> assign(notification_params: params)

    {:ok, socket}
  end
end
