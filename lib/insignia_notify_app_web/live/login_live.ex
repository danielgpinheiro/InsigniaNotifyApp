defmodule InsigniaNotifyAppWeb.LoginLive do
  use InsigniaNotifyAppWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="flex items-center justify-center w-full h-full p-2">
      <div class="w-full max-w-xs">
        <form class="bg-gray-700 shadow-md rounded px-8 pt-6 pb-8 mb-4">
          <img src="/images/logo.png" class="w-[48px] mx-auto mb-5" />

          <div class="flex flex-wrap -mx-3 mb-6">
            <div class="w-full px-3 mb-6 md:mb-0">
              <label
                class="block uppercase tracking-wide text-white text-xs font-bold font-chakra mb-2"
                for="grid-first-name"
              >
                E-mail
              </label>
              <input
                class="appearance-none block w-full bg-gray-600 text-white border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-gray-700"
                id="grid-first-name"
                type="text"
                placeholder="e-mail"
              />
            </div>
          </div>
          <div class="flex flex-col items-center justify-between">
            <button
              class="bg-xbox-green text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline font-chakra"
              type="button"
            >
              Sign In
            </button>
            <a class="inline-block align-baseline font-bold text-sm text-white mt-6" href="#">
              Register
            </a>
            <a class="inline-block align-baseline font-bold text-sm text-white mt-6" href="#">
              Anonymous Sign In
            </a>
          </div>
        </form>
        <p class="text-center text-gray-500 text-xs">
          The account is only for saving notification preferences, we will not use your email for spam
          or disclose your data.
        </p>
      </div>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("notification-params", _, socket) do
    {:noreply, socket}
  end
end
