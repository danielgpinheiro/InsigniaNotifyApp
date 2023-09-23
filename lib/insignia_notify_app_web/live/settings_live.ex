defmodule InsigniaNotifyAppWeb.SettingsLive do
  use InsigniaNotifyAppWeb, :live_view

  alias Phoenix.LiveView.JS

  def render(assigns) do
    ~H"""
    <section>
      <.header />

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
              id="countries"
              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
            >
              <option selected>Choose a sound</option>
              <option value="US">No Sound</option>
              <option value="CA">Canada</option>
              <option value="FR">France</option>
              <option value="DE">Germany</option>
            </select>
          </form>
        </div>

        <div class="w-full lg:w-[50%] flex flex-col p-6">
          <h3 class="text-white text-2xl mb-5">Delete Account</h3>

          <p class="text-white mb-2">Permanently delete your account</p>

          <button class="w-[150px] bg-transparent font-bold py-2 px-4 rounded inline-flex items-center border-[1px] border-[red]">
            <i class="material-symbols-rounded text-[red] w-10 text-center">delete</i>
            <span class="text-[red]">Delete account</span>
          </button>
        </div>
      </div>

      <button
        class="flex items-center h-full w-full hover:bg-gray-600"
        phx-click={JS.dispatch("showNotification", detail: "teste123qadwa")}
      >
        <i class="material-symbols-rounded text-white w-10 text-center">logout</i>
        <span class="text-white pl-2">Teste</span>
      </button>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
