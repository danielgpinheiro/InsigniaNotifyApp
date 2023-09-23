defmodule InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  def request_notification(assigns) do
    ~H"""
    <div class="fixed bottom-0 right-0 z-10 p-2">
      <div class="w-full lg:w-[300px] bg-[#fff4e5] rounded px-3 pt-3 pb-10">
        <div>
          <strong class="font-chakra">iOS install required</strong>
          <br />
          <span class="font-chakra">
            Click on the Share icon and Add to Home Screen to enable notifications on iOS
          </span>
        </div>

        <div>
          <strong class="font-chakra">Notifications are disabled</strong>
          <br />
          <span class="font-chakra">
            Grant your browser permission to display desktop notifications
          </span>

          <br />

          <button
            class="font-chakra font-bold absolute bottom-5 right-6"
            phx-click={JS.dispatch("requestNotificationPermission", detail: "testeshow")}
          >
            Grant Now
          </button>
        </div>
      </div>
    </div>
    """
  end
end
