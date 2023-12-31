defmodule InsigniaNotifyAppWeb.GamesLive do
  use InsigniaNotifyAppWeb, :live_view

  alias InsigniaNotifyAppWeb.FirebaseTokenController

  alias InsigniaNotifyAppWeb.Shared.GameList.GameListComponent
  alias InsigniaNotifyAppWeb.Shared.Filter.FilterComponent
  alias InsigniaNotifyAppWeb.Shared.Header.HeaderComponent
  alias InsigniaNotifyAppWeb.Shared.Footer.FooterComponent

  def render(assigns) do
    ~H"""
    <section id="games">
      <.live_component module={HeaderComponent} id={:header} />

      <%!-- <.live_component module={FilterComponent} id={:filter_form} /> --%>

      <%!-- <.live_component module={GameListComponent} id={:game_list} /> --%>

      <FooterComponent.footer />
    </section>
    """
  end

  def mount(_, _, socket) do
    if connected?(socket), do: send(self(), :check_fb_token)

    {:ok, socket}
  end

  def handle_info(:check_fb_token, socket) do
    {:noreply, push_event(socket, "readFbToken", %{})}
  end

  def handle_event(
        "generatedFbToken",
        %{"current_fb_token" => current_fb_token, "old_fb_token" => old_fb_token} =
          _params,
        socket
      ) do
    case current_fb_token do
      nil -> {:noreply, push_navigate(socket, to: ~p"/login", replace: true)}
      _ -> {:noreply, socket}
    end
  end
end
