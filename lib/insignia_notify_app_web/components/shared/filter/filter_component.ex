defmodule InsigniaNotifyAppWeb.Shared.Filter.FilterComponent do
  use Phoenix.LiveComponent

  alias InsigniaNotifyAppWeb.Shared.Filter.FormComponent

  def render(assigns) do
    ~H"""
    <div class="flex flex-col lg:w-[1140px] w-full mt-20 lg:mt-24 mb-5 mx-auto px-4 lg:px-0">
      <.live_component module={FormComponent} id={:form} />

      <div class="flex items-center justify-between lg:flex-row flex-col">
        <div class="lg:mb-0 mb-6 text-center">
          <span class="text-gray-300 font-chakra mr-5">
            <strong>7.773</strong> Registered Users
          </span>
          <span class="text-gray-300 font-chakra mr-5">
            <strong>5</strong> Users Online Now
          </span>
          <span class="text-gray-300 font-chakra">
            <strong>130</strong> Games Supported
          </span>
        </div>

        <form class="flex item-center text-white font-chakra rounded bg-gray-700 relative">
          <select class="bg-transparent border-none pr-8">
            <option>Order by Active Users</option>
            <option>Order by Active Sessions</option>
            <option>Order by Online Users</option>
            <option>Order by Game Title</option>
          </select>
        </form>
      </div>
    </div>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end
end
