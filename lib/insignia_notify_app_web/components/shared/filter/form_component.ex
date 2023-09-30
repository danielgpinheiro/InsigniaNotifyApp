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
          <.input
            id="filter-game"
            name="filter-game"
            phx-change="filter-game"
            phx-target={@myself}
            value={@filter_text}
            placeholder="Filter by Title, Serial and Game Code"
          >
          </.input>
        </div>
      </div>
    </form>
    """
  end

  def mount(socket) do
    {:ok, socket |> assign(:filter_text, "")}
  end

  def handle_event(
        "filter-game",
        %{"_target" => ["filter-game"], "filter-game" => filter},
        socket
      ) do
    IO.inspect(filter)

    {:noreply, socket}
  end
end
