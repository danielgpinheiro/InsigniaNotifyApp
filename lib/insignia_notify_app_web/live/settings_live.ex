defmodule InsigniaNotifyAppWeb.SettingsLive do
  alias InsigniaNotifyAppWeb.SettingsController
  use InsigniaNotifyAppWeb, :live_view

  alias InsigniaNotifyApp.Identity

  alias InsigniaNotifyAppWeb.Shared.Notification.RequestNotificationPermissionComponent
  alias InsigniaNotifyAppWeb.Shared.Header.HeaderComponent

  def render(assigns) do
    ~H"""
    <section>
      <.live_component module={HeaderComponent} id={:header} current_user={@current_user} />

      <.live_component
        module={RequestNotificationPermissionComponent}
        id={:request_notification}
        params={assigns}
      />

      <div class="w-[95%] lg:w-[1140px] bg-gray-700 mt-20 mx-auto rounded p-2 flex flex-col">
        <button
          class="flex items-center w-[100px] h-[48px] hover:bg-gray-600 rounded"
          phx-click={JS.navigate("/games")}
        >
          <i class="material-symbols-rounded text-white w-10 text-center">arrow_back</i>
          <span class="text-white pl-2">Back</span>
        </button>

        <div class="w-full lg:w-[50%] flex flex-col p-6">
          <h3 class="text-white text-2xl mb-5">Notifications</h3>

          <form>
            <label
              for="countries"
              class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
            >
              Notification Sound
            </label>
            <select
              id="notification-sound"
              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
              name="notification-sound"
              phx-change="notification-settings"
            >
              <option selected>Choose a sound</option>
              <option value="">No Sound</option>
              <option value="beep">beep</option>
              <option value="dadum">dadum</option>
              <option value="ding">ding</option>
              <option value="juntos">juntos</option>
              <option value="pop-swoosh">pop-swoosh</option>
              <option value="pop">pop</option>
              <option value="pristine">pristine</option>
            </select>
          </form>
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
    {:ok, socket}
  end

  def handle_event("notification-params", %{"params" => params}, socket) do
    send_update(RequestNotificationPermissionComponent, id: :request_notification, params: params)
    {:noreply, socket}
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

    {:noreply, socket}
  end
end
