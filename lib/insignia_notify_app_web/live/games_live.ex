defmodule InsigniaNotifyAppWeb.GamesLive do
  use InsigniaNotifyAppWeb, :live_view

  alias Phoenix.LiveView.JS
  alias InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent

  def render(assigns) do
    ~H"""
    <section>
      <.header />

      <.live_component
        module={RequestNotificationPermissionComponent}
        id={:request_notification}
        params={assigns}
      />

      <div>abc</div>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("notification-params", %{"params" => params}, socket) do
    send_update(RequestNotificationPermissionComponent, id: :request_notification, params: params)
    {:noreply, socket}
  end
end
