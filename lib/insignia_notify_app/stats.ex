defmodule InsigniaNotifyApp.Stats do
  alias InsigniaNotifyApp.Stats.Create
  alias InsigniaNotifyApp.Stats.Get
  alias InsigniaNotifyApp.Stats.Update

  defdelegate get(), to: Get, as: :call
  defdelegate create(params), to: Create, as: :call
  defdelegate update(stats, params), to: Update, as: :call
end
