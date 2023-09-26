defmodule InsigniaNotifyAppWeb.Shared.Header.AccountMenuComponent do
  use InsigniaNotifyAppWeb, :live_component
  use InsigniaNotifyAppWeb, :verified_routes

  def render(assigns) do
    ~H"""
    <ul
      id="account-menu"
      class="absolute top-[72px] right-[5px] bg-gray-700 w-[240px] rounded shadow-md before:content-[''] before:block before:absolute before:top-0 before:right-[19px] before:w-[10px] before:h-[10px] before:bg-gray-700 before:translate-y-[-50%] before:rotate-45 hidden"
    >
      <li class="h-11 flex items-center border-b-[1px] border-white">
        <i class="material-symbols-rounded text-white w-10 text-center">account_circle</i>
        <strong class="text-white pl-2"><%= @current_user.email %></strong>
      </li>

      <li class="h-11">
        <.link
          href={~p"/settings"}
          class="flex items-center h-full w-full hover:bg-gray-600 !no-underline"
        >
          <i class="material-symbols-rounded text-white w-10 text-center">settings</i>
          <span class="text-white pl-2">
            Settings
          </span>
        </.link>
      </li>

      <li class="h-11">
        <.link
          href={~p"/session"}
          method="delete"
          class="flex items-center h-full w-full hover:bg-gray-600 !no-underline"
        >
          <i class="material-symbols-rounded text-white w-10 text-center">logout</i>
          <span class="text-white pl-2">
            Sign Out
          </span>
        </.link>
      </li>
    </ul>
    """
  end
end
