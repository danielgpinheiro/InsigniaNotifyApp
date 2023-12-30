defmodule InsigniaNotifyAppWeb.LoginLive do
  use InsigniaNotifyAppWeb, :live_view

  alias InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent

  def render(assigns) do
    ~H"""
    <section
      phx-hook="Fingerprint"
      id="login"
      class="w-full h-[100vh] relative flex justify-center items-center"
    >
      <img src="/images/loading.svg" class="w-20" />
    </section>
    """
  end

  def mount(_, _, socket) do
    if connected?(socket), do: send(self(), :gererateVisitorId)

    {:ok, socket}
  end

  def handle_info(:gererateVisitorId, socket) do
    {:noreply, push_event(socket, "gererateVisitorId", %{})}
  end

  def handle_event("visitorIdCreated", _, socket) do
    {:noreply, push_navigate(socket, to: ~p"/games", replace: true)}
  end
end
