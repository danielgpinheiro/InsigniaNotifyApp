defmodule InsigniaNotifyAppWeb.Shared.Header.HeaderComponent do
  alias InsigniaNotifyAppWeb.SettingsController
  use InsigniaNotifyAppWeb, :live_component

  def render(assigns) do
    ~H"""
    <header
      class="flex justify-between items-center lg:h-16 h-14 bg-white fixed top-0 left-0 w-full z-10 shadow-lg"
      style="background: linear-gradient(150deg, rgb(20, 124, 26) 0%, rgb(141, 193, 3)"
    >
      <div class="flex items-center px-6">
        <img src="/images/logo.png" class="w-[36px] lg:w-[48px] rounded-md" alt="" />

        <h1 class="ml-4 text-lg lg:text-xl font-chakra font-medium text-white">Insignia Notify</h1>
      </div>

      <div class="flex">
        <button
          class="flex items-center justify-center w-[64px] h-[64px]"
          phx-click="change_enabled_notifications"
          phx-target={@myself}
          data-tippy-content={"#{if @enabled_notification, do: "Disable", else: "Enable"} notifications"}
        >
          <i class="material-symbols-rounded !text-[24px] text-white">
            <%= if @enabled_notification, do: "notifications_off", else: "notifications" %>
          </i>
        </button>

        <.link class="flex items-center justify-center w-[64px] h-[64px]" href={~p"/settings"}>
          <i class="material-symbols-rounded !text-[24px] text-white">settings</i>
        </.link>
      </div>
    </header>
    """
  end

  def mount(socket) do
    {:ok, socket |> assign(enabled_notification: true) |> assign(goTo: "")}
  end

  def update(%{user_id: user_id, goTo: goTo} = _assigns, socket) do
    {_, value} = SettingsController.get_enabled_notifications_by_user_id(user_id)

    enabled = if value == :not_found, do: true, else: value.enabled

    {
      :ok,
      socket
      |> assign(:user_id, user_id)
      |> assign(goTo: goTo)
      |> assign(enabled_notification: enabled)
    }
  end

  def handle_event(
        "change_enabled_notifications",
        _,
        socket
      ) do
    user_id = socket.assigns.user_id
    enabled_notification = !socket.assigns.enabled_notification

    SettingsController.change_enabled_notifications(%{
      user_id: user_id,
      enabled: enabled_notification
    })

    {:noreply,
     push_event(
       socket
       |> assign(enabled_notification: enabled_notification)
       |> assign(user_id: user_id)
       |> assign(loading: false),
       "initializeTooltip",
       %{}
     )}
  end
end
