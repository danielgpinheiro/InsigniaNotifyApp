defmodule InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent do
  use Phoenix.LiveComponent

  alias Phoenix.LiveView.JS

  def render(assigns) do
    ~H"""
    <div>
      <%= if Map.get(@params, "permission") != "granted" do %>
        <div class="fixed bottom-0 right-0 z-10 p-2">
          <div class="w-full lg:w-[300px] bg-[#fff4e5] rounded text-[#000]">
            <%= if Map.get(@params, "isIOSButNotInstalled") do %>
              <div class="pb-4 px-3 pt-3">
                <strong class="font-chakra">iOS install required</strong>
                <br />
                <span class="font-chakra">
                  Click on the Share icon and Add to Home Screen to enable notifications on iOS
                </span>
              </div>
            <% end %>

            <%= if Map.get(@params, "permission") == "default" and !Map.get(@params, "isIOSButNotInstalled") do %>
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

  def update(%{params: params} = _assigns, socket) do
    socket =
      socket
      |> assign(params: params)

    {:ok, socket}
  end
end
