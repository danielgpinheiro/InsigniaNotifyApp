defmodule InsigniaNotifyAppWeb.SettingsLive do
  use InsigniaNotifyAppWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <.header>Settings</.header>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
