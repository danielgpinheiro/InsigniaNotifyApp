defmodule InsigniaNotifyAppWeb.GamesLive do
  use InsigniaNotifyAppWeb, :live_view

  alias InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent
  alias InsigniaNotifyAppWeb.Shared.GameList.GameListComponent
  alias InsigniaNotifyAppWeb.Shared.Filter.FilterComponent
  alias InsigniaNotifyAppWeb.Shared.Header.HeaderComponent
  alias InsigniaNotifyAppWeb.Shared.Footer.FooterComponent

  def render(assigns) do
    ~H"""
    <section>
      <.live_component module={HeaderComponent} id={:header} current_user={@current_user} />

      <.live_component
        module={RequestNotificationPermissionComponent}
        id={:request_notification}
        notification_params={@notification_params}
      />

      <.live_component
        module={FilterComponent}
        id={:filter_form}
        current_user={@current_user}
        stats={@stats}
      />

      <.live_component
        module={GameListComponent}
        id={:game_list}
        current_user={@current_user}
        firebase_user_token={@firebase_user_token}
      />

      <FooterComponent.footer />
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(stats: %{})
      |> assign(notification_params: %{})
      |> assign(firebase_user_token: "")
    }
  end

  def handle_event("notification-params", %{"params" => params}, socket) do
    permissions = Map.get(params, "permissions")
    firebase_user_token = Map.get(params, "firebaseUserToken")

    send_update(RequestNotificationPermissionComponent,
      id: :request_notification,
      notification_params: permissions
    )

    {:noreply, socket |> assign(firebase_user_token: firebase_user_token)}
  end
end
