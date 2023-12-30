defmodule InsigniaNotifyAppWeb.LoginLive do
  use InsigniaNotifyAppWeb, :live_view

  def render(assigns) do
    ~H"""
    <p class="text-white">opa</p>
    """
  end

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
    }
  end

  def handle_event("notification-permissions", permissions, socket) do
    # permissions = Map.get(params, "permissions")

    # send_update(RequestNotificationPermissionComponent,
    #   id: :request_notification,
    #   notification_params: permissions
    # )

    # FirebaseTokenController.change_firebase_token(%{
    #   user_id: socket.assigns.current_user.id,
    #   firebase_token: firebase_user_token
    # })
    IO.inspect(permissions)

    {:noreply, socket}
  end
end
