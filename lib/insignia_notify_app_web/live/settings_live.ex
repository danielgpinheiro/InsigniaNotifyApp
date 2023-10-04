defmodule InsigniaNotifyAppWeb.SettingsLive do
  use InsigniaNotifyAppWeb, :live_view

  alias InsigniaNotifyApp.Identity

  alias InsigniaNotifyApp.Settings.Setting
  alias InsigniaNotifyAppWeb.SettingsController

  alias InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent
  alias InsigniaNotifyAppWeb.Shared.Header.HeaderComponent

  def render(assigns) do
    ~H"""
    <section>
      <.live_component module={HeaderComponent} id={:header} current_user={@current_user} />

      <.live_component
        module={RequestNotificationPermissionComponent}
        id={:request_notification}
        notification_params={@notification_params}
      />

      <div class="w-[95%] lg:w-[1140px] bg-gray-700 mt-20 mx-auto rounded p-2 flex flex-col">
        <button
          class="flex items-center w-[100px] h-[48px] hover:bg-gray-600 rounded"
          phx-click={JS.navigate("/games")}
        >
          <i class="material-symbols-rounded text-white w-10 text-center">arrow_back</i>
          <span class="text-white pl-2">Back</span>
        </button>

        <div class="w-full lg:w-[50%] flex flex-col p-6 relative">
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
            class="right-[-20px] bottom-[30px] absolute border-[1px] rounded-full w-8 h-8"
            phx-click={JS.dispatch("playSound", detail: @sound)}
          >
            <i class="material-symbols-rounded text-white text-center">play_arrow</i>
          </button>
        </div>

        <div class="w-full lg:w-[50%] flex flex-col p-6">
          <h3 class="text-white text-2xl mb-5">Delete Account</h3>

          <p class="text-white mb-2">Permanently delete your account</p>

          <button
            class="w-[150px] bg-transparent font-bold py-2 px-4 rounded inline-flex items-center border-[1px] border-[red]"
            phx-click="delete-account"
          >
            <i class="material-symbols-rounded text-[red] w-10 text-center">delete</i>
            <span class="text-[red]">Delete account</span>
          </button>
        </div>
      </div>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id

    case SettingsController.get_settings_by_user_id(user_id) do
      {:ok, %Setting{notification_sound: notification_sound}} ->
        {:ok, socket |> assign(:sound, notification_sound) |> assign(notification_params: %{})}

      {:error, _} ->
        {:ok,
         socket
         |> assign(:sound, "beep")
         |> assign(notification_params: %{})
         |> assign(firebaseUserToken: "")}
    end
  end

  def handle_event("notification-params", %{"params" => params}, socket) do
    permissions = Map.get(params, "permissions")
    firebaseUserToken = Map.get(params, "firebaseUserToken")

    send_update(RequestNotificationPermissionComponent,
      id: :request_notification,
      notification_params: permissions
    )

    {:noreply, socket |> assign(firebaseUserToken: firebaseUserToken)}
  end

  def handle_event("delete-account", _, socket) do
    current_user = socket.assigns.current_user
    user_id = current_user.id

    Identity.delete(current_user)

    user_id
    |> Identity.delete_all_user_sessions()

    {:noreply, push_navigate(socket, to: "/login", replace: true)}
  end

  def handle_event(
        "notification-settings",
        %{"_target" => ["notification-sound"], "notification-sound" => sound},
        socket
      ) do
    user_id = socket.assigns.current_user.id
    SettingsController.change_settings(%{user_id: user_id, notification_sound: sound})

    {:noreply, socket |> assign(:sound, sound)}
  end
end
