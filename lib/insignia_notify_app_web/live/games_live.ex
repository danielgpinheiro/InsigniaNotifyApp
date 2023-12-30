defmodule InsigniaNotifyAppWeb.GamesLive do
  use InsigniaNotifyAppWeb, :live_view

  alias InsigniaNotifyAppWeb.FirebaseTokenController

  alias InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent
  alias InsigniaNotifyAppWeb.Shared.GameList.GameListComponent
  alias InsigniaNotifyAppWeb.Shared.Filter.FilterComponent
  alias InsigniaNotifyAppWeb.Shared.Header.HeaderComponent
  alias InsigniaNotifyAppWeb.Shared.Footer.FooterComponent

  def render(assigns) do
    ~H"""
    <section>
      <.live_component module={HeaderComponent} id={:header} />

      <.live_component
        module={RequestNotificationPermissionComponent}
        id={:request_notification}
        notification_params={@notification_params}
      />

      <%!-- <.live_component module={FilterComponent} id={:filter_form} /> --%>

      <%!-- <.live_component module={GameListComponent} id={:game_list} /> --%>

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
      |> assign(current_user: %{id: "123"})
    }
  end

  def handle_event("notification-permissions", %{"params" => params}, socket) do
    permissions = Map.get(params, "permissions")
    firebase_user_token = Map.get(params, "firebaseUserToken")

    # send_update(RequestNotificationPermissionComponent,
    #   id: :request_notification,
    #   notification_params: permissions
    # )

    # FirebaseTokenController.change_firebase_token(%{
    #   user_id: socket.assigns.current_user.id,
    #   firebase_token: firebase_user_token
    # })
    IO.inspect(firebase_user_token)
    IO.inspect(permissions)

    {:noreply, socket}
  end
end
