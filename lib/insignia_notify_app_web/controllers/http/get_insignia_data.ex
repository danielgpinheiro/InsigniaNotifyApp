defmodule InsigniaNotifyAppWeb.Http.GetInsigniaData do
  alias InsigniaNotifyAppWeb.Http.Api

  def get(insignia_url) do
    Api.get(insignia_url)
  end
end
