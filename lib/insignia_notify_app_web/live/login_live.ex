defmodule InsigniaNotifyAppWeb.LoginLive do
  use InsigniaNotifyAppWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      Login
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
