defmodule InsigniaNotifyAppWeb.Shared.Header.HeaderComponent do
  use InsigniaNotifyAppWeb, :live_component

  alias InsigniaNotifyAppWeb.Shared.Header.AccountMenuComponent

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
        <%!-- <button class="flex items-center justify-center w-[64px] h-[64px]">
          <i class="material-symbols-rounded !text-[24px] text-white">notifications</i>
          <!-- <i class="material-symbols-rounded !text-[24px] text-white">notifications_off</i> -->
        </button> --%>

        <button
          class="flex items-center justify-center w-[64px] h-[64px]"
          phx-click={
            JS.toggle(
              to: "#account-menu",
              in: {"ease-out duration-150", "opacity-0", "opacity-100"},
              out: {"ease-out duration-150", "opacity-100", "opacity-0"}
            )
          }
        >
          <i class="material-symbols-rounded !text-[24px] text-white">account_circle</i>
        </button>
      </div>

      <%!-- <.live_component module={AccountMenuComponent} id={:account_menu} current_user={@current_user} /> --%>
    </header>
    """
  end
end
