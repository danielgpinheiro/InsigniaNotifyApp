defmodule InsigniaNotifyAppWeb.Http.HandleResponse do
  def response(:ok, params) do
    {:ok, params}
  end

  def response(:error, reason) do
    {:error, reason}
  end
end
