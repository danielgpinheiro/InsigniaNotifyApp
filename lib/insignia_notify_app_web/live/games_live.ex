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
    <section phx-hook="Fingerprint" id="games">
      <.live_component module={HeaderComponent} id={:header} />

      <.live_component module={RequestNotificationPermissionComponent} id={:request_notification} />

      <%!-- <.live_component module={FilterComponent} id={:filter_form} /> --%>

      <%!-- <.live_component module={GameListComponent} id={:game_list} /> --%>

      <FooterComponent.footer />
    </section>
    """
  end

  def mount(_, _, socket) do
    if connected?(socket), do: send(self(), :visitorId)

    {:ok, socket}
  end

  def handle_info(:visitorId, socket) do
    {:noreply, push_event(socket, "readVisitorId", %{})}
  end

  def handle_event(
        "readVisitorId",
        %{"current_visitor_id" => current_visitor_id, "old_visitor_id" => old_visitor_id} =
          _params,
        socket
      ) do
    case current_visitor_id do
      nil -> {:noreply, push_navigate(socket, to: ~p"/login", replace: true)}
      _ -> {:noreply, socket}
    end
  end
end
