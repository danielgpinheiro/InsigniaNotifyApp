defmodule InsigniaNotifyAppWeb.Shared.Filter.FormComponent do
  use InsigniaNotifyAppWeb, :live_component

  def render(assigns) do
    ~H"""
    <form class="w-full">
      <div class="flex flex-wrap -mx-3 lg:mb-6 mb-0">
        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
          <label
            class="block uppercase tracking-wide text-white text-xs font-bold font-chakra mb-2"
            for="grid-first-name"
          >
            Filter
          </label>
          <input
            class="appearance-none block w-full bg-gray-600 text-white border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-gray-700"
            id="grid-first-name"
            type="text"
            placeholder="Filter by Title, Serial and Game Code"
          />
        </div>
      </div>
    </form>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end
end
