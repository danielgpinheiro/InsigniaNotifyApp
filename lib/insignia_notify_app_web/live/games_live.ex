defmodule InsigniaNotifyAppWeb.GamesLive do
  use InsigniaNotifyAppWeb, :live_view

  alias InsigniaNotifyAppWeb.TokenController

  alias InsigniaNotifyAppWeb.Shared.GameList.GameListComponent
  alias InsigniaNotifyAppWeb.Shared.Filter.FilterComponent
  alias InsigniaNotifyAppWeb.Shared.Header.HeaderComponent
  alias InsigniaNotifyAppWeb.Shared.Footer.FooterComponent

  def render(assigns) do
    ~H"""
    <section id="games" phx-hook="Tooltip">
      <%= if @loading do %>
        <div class="w-full h-[100vh] relative flex justify-center items-center">
          <img src="/images/loading.svg" class="w-20" />
        </div>
      <% end %>

      <%= if !@loading do %>
        <.live_component module={HeaderComponent} id={:header} user_id={@user_id} goTo="settings" />

        <.live_component module={FilterComponent} id={:filter_form} user_id={@user_id} />

        <.live_component module={GameListComponent} id={:game_list} user_id={@user_id} />

        <FooterComponent.footer />
      <% end %>
    </section>
    """
  end

  def mount(_, _, socket) do
    if connected?(socket), do: send(self(), :check_fb_token)

    {:ok, socket |> assign(user_token: "") |> assign(loading: true)}
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
      nil ->
        {:noreply, push_navigate(socket, to: ~p"/login", replace: true)}

      _ ->
        {status, user_id} = TokenController.check_token(old_fb_token, current_fb_token)

        if status == :update,
          do: {:noreply, push_event(socket, "updateFbOldToken", %{token: current_fb_token})},
          else:
            {:noreply,
             push_event(
               socket |> assign(user_id: user_id) |> assign(loading: false),
               "initializeTooltip",
               %{}
             )}
    end
  end
end
