defmodule InsigniaNotifyAppWeb.GamesLive do
  use InsigniaNotifyAppWeb, :live_view

  def render(assigns) do
    ~H"""
    <section>
      <.header />
      <.footer />
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
