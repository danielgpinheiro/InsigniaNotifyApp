defmodule InsigniaNotifyAppWeb.SettingsLive do
  use InsigniaNotifyAppWeb, :live_view

  alias InsigniaNotifyApp.Settings.Setting
  alias InsigniaNotifyAppWeb.SettingsController

  alias InsigniaNotifyAppWeb.Shared.Footer.FooterComponent
  alias InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent
  alias InsigniaNotifyAppWeb.Shared.Header.HeaderComponent

  def render(assigns) do
    ~H"""
    <section phx-hook="Sound" id="settings" class="w-full h-[100vh] flex flex-col justify-between">
      <%= if @loading do %>
        <div class="w-full h-[100vh] relative flex justify-center items-center">
          <img src="/images/loading.svg" class="w-20" />
        </div>
      <% end %>

      <%= if !@loading do %>
        <.live_component module={HeaderComponent} id={:header} />

        <div class="w-[95%] lg:w-11/12 max-w-[1140px] bg-gray-700 mt-20 mx-auto rounded p-2 flex flex-col">
          <button
            class="flex items-center w-[100px] h-[48px] hover:bg-gray-600 rounded"
            phx-click={JS.navigate("/games")}
          >
            <i class="material-symbols-rounded text-white w-10 text-center">arrow_back</i>
            <span class="text-white pl-2">Back</span>
          </button>

          <div class="w-full lg:w-[50%] flex flex-col p-6 pr-20 lg:pr-6 relative">
            <h3 class="text-white text-2xl mb-5">Notifications</h3>

            <form>
              <label
                for="countries"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
              >
                Notification Sound
              </label>

              <.input
                id="notification-sound"
                type="select"
                options={[
                  "no-sound",
                  "beep",
                  "dadum",
                  "ding",
                  "juntos",
                  "pop-swoosh",
                  "pop",
                  "pristine"
                ]}
                name="notification-sound"
                value={@sound}
                phx-change="notification-settings"
              >
              </.input>
            </form>

            <button
              class="right-[30px] lg:right-[-20px] bottom-[30px] absolute border-[1px] rounded-full w-8 h-8"
              phx-click={JS.dispatch("playSound", detail: @sound)}
            >
              <i class="material-symbols-rounded text-white text-center">play_arrow</i>
            </button>
          </div>
        </div>

        <FooterComponent.footer />
      <% end %>
    </section>
    """
  end

  def mount(_, _, socket) do
    if connected?(socket), do: send(self(), :check_fb_token)

    {:ok, socket |> assign(user_token: "") |> assign(sound: "beep") |> assign(loading: true)}
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
        get_settings(current_fb_token)
        {:noreply, socket |> assign(user_token: current_fb_token) |> assign(loading: false)}
    end
  end

  defp get_settings(user_token) do
    IO.inspect(user_token)
    # case SettingsController.get_settings_by_user_id(user_token) do
    #   {:ok, %Setting{notification_sound: notification_sound}} ->
    #     {:ok, socket |> assign(:sound, notification_sound) |> assign(notification_params: %{})}

    #   {:error, _} ->
    #     {:ok,
    #      socket
    #      |> assign(:sound, "beep")
    #      |> assign(notification_params: %{})}
    # end
  end

  def handle_event(
        "notification-settings",
        %{"_target" => ["notification-sound"], "notification-sound" => sound},
        socket
      ) do
    user_token = socket.assigns.user_token
    SettingsController.change_settings(%{user_token: user_token, notification_sound: sound})

    {:noreply, socket |> assign(:sound, sound)}
  end
end
