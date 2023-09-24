defmodule InsigniaNotifyAppWeb.GamesLive do
  use InsigniaNotifyAppWeb, :live_view

  alias InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent
  alias InsigniaNotifyAppWeb.Shared.GameList.GameListComponent
  alias InsigniaNotifyAppWeb.Shared.Filter.FilterComponent

  def render(assigns) do
    ~H"""
    <section>
      <.header />

      <.live_component
        module={RequestNotificationPermissionComponent}
        id={:request_notification}
        params={assigns}
      />

      <.live_component module={FilterComponent} id={:filter_form} />

      <.live_component module={GameListComponent} id={:game_list} />

      <.footer />
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
