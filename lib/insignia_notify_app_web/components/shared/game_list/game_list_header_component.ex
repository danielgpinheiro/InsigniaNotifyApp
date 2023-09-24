defmodule InsigniaNotifyAppWeb.Shared.GameList.GameListHeaderComponent do
  use Phoenix.LiveComponent

  alias Phoenix.LiveView.JS

  def render(assigns) do
    ~H"""
    <div class="w-full flex relative p-1 flex-wrap lg:flex-nowrap">
      <div class="flex">
        <img
          src="https://r2-cdn.insignia.live/Shl9AF66oSfXRmcAdNj580DyHtpLfm8ETKBnnD1i.png"
          class="w-16 h-16 lg:w-24 lg:h-24 rounded"
          alt=""
        />

        <div class="game-info flex flex-col lg:ml-6 ml-2 justify-center w-[300px] shrink-0">
          <a
            href="https://insignia.live/games/MS-074"
            target="_blank"
            class="text-white text-base font-chakra truncate lg:text-clip w-[80%] lg:w-auto"
          >
            Phantasy Star Online Episode I & II
          </a>

          <strong class="text-gray-300 text-sm">MS-074</strong>
          <span class="text-gray-300 text-sm">4D53004A</span>
        </div>
      </div>

      <div class="stats flex space-between items-center w-full lg:w-[35%] shrink-0 pr-10 lg:pr-0 mt-4 lg:mt-0">
        <strong class="text-white text-sm flex flex-col text-center font-chakra relative px-6 after:content-['*'] after:absolute after:top-[calc(50%-2px)] after:right-0 after:w-[5px] after:h-[5px] last:after:hidden">
          Online Users <span class="text-gray-300 text-base">9999</span>
        </strong>

        <strong class="text-white text-sm flex flex-col text-center font-chakra relative px-6 after:content-['*'] after:absolute after:top-[calc(50%-2px)] after:right-0 after:w-[5px] after:h-[5px] last:after:hidden">
          Active Users <span class="text-gray-300 text-base">9999</span>
        </strong>

        <strong class="text-white text-sm flex flex-col text-center font-chakra relative px-6 after:content-['*'] after:absolute after:top-[calc(50%-2px)] after:right-0 after:w-[5px] after:h-[5px] last:after:hidden">
          Active Sessions <span class="text-gray-300 text-base">9999</span>
        </strong>
      </div>

      <div class="features flex flex-col justify-center w-full lg:w-[20%] my-4 lg:my-0">
        <strong class="text-white font-chakra mb-2 pl-2">Features</strong>

        <div class="flex w-full justify-around">
          <i
            class="material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer"
            title="Xbox Live Aware"
          >
            person
          </i>
          <i
            class="material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer"
            title="Matchmaking"
          >
            language
          </i>
          <i
            class="material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer"
            title="Leaderboards"
          >
            leaderboard
          </i>
          <i
            class="material-symbols-rounded text-gray-300 hover:text-xbox-green cursor-pointer"
            title="User Generated Content"
          >
            extension
          </i>
        </div>
      </div>

      <button
        class="absolute top-[calc(50%-20px)] right-4"
        title="Expand to toggle notifications and view matches"
        phx-click={JS.dispatch("toggleAccordion")}
      >
        <span class="material-symbols-rounded !text-4xl text-white expand-more">expand_more</span>
        <span class="material-symbols-rounded !text-4xl text-white expand-less !hidden">
          expand_less
        </span>
      </button>
    </div>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end
end
