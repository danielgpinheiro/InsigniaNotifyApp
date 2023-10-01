defmodule InsigniaNotifyApp.Games do
  alias InsigniaNotifyApp.Games.Create
  alias InsigniaNotifyApp.Games.Get
  alias InsigniaNotifyApp.Games.Update

  defdelegate get(serial), to: Get, as: :call_get
  defdelegate get_all(), to: Get, as: :call_get_all
  defdelegate create(params), to: Create, as: :call
  defdelegate update(game, params), to: Update, as: :call
end
