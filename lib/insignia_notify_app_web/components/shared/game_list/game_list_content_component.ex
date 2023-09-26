defmodule InsigniaNotifyAppWeb.Shared.GameList.GameListContentComponent do
  use InsigniaNotifyAppWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="w-full bg-gray-600 flex overflow-hidden max-h-0 transition-[max-height] ease-out max-h-0 will-change-[max-height] accordion-content flex-wrap lg:flex-nowrap">
      <div class="w-full lg:w-[40%] flex-col">
        <h3 class="font-chakra text-white text-lg p-5">Notifications</h3>

        <form class="p-5 w-full flex-col">
          <div class="flex justify-between mb-6">
            <span class="font-base font-roboto text-gray-300">Notify when have new sessions</span>

            <label class="slideon">
              <input type="checkbox" class="slideon slideon-auto slideon-success" checked />
              <span class="slideon-slider"></span>
            </label>
          </div>

          <div class="flex justify-between mb-6">
            <span class="font-base font-roboto text-gray-300">Notify when sessions end</span>

            <label class="slideon">
              <input type="checkbox" class="slideon slideon-auto slideon-success" />
              <span class="slideon-slider"></span>
            </label>
          </div>

          <div class="flex justify-between mb-6">
            <span class="font-base font-roboto text-gray-300">
              Notify when sessions have new players
            </span>

            <label class="slideon">
              <input type="checkbox" class="slideon slideon-auto slideon-success" />
              <span class="slideon-slider"></span>
            </label>
          </div>

          <div class="flex justify-between mb-6">
            <span class="font-base font-roboto text-gray-300">
              Notify when sessions have fewer players
            </span>

            <label class="slideon">
              <input type="checkbox" class="slideon slideon-auto slideon-success" />
              <span class="slideon-slider"></span>
            </label>
          </div>
        </form>
      </div>

      <div class="w-full lg:w-[60%] flex-col pb-2 lg:pb-0">
        <h3 class="font-chakra text-white text-lg p-5">Matches</h3>

        <div class="max-h-[200px] overflow-y-auto overflow-x-hidden relative">
          <ul class="table border-collapse table-fixed w-full ml-5">
            <li class="table-row">
              <div class="table-cell">
                <strong class="text-white font-chakra">Host</strong>
              </div>
              <div class="table-cell">
                <strong class="text-white font-chakra">Dedicated</strong>
              </div>
              <div class="table-cell">
                <strong class="text-white font-chakra">Players</strong>
              </div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
            <li class="table-row">
              <div class="table-cell text-white">LightWish</div>
              <div class="table-cell text-white">N</div>
              <div class="table-cell text-white">6/32</div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end
end
