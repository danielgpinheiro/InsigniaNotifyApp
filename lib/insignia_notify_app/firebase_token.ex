defmodule InsigniaNotifyApp.FirebaseToken do
  alias InsigniaNotifyApp.FirebaseToken.Create
  alias InsigniaNotifyApp.FirebaseToken.Get
  alias InsigniaNotifyApp.FirebaseToken.Update

  defdelegate get_by(firebase_token), to: Get, as: :get_by
  defdelegate get_all(), to: Get, as: :get_all
  defdelegate create(params), to: Create, as: :call
  defdelegate update(tokens, params), to: Update, as: :call
end
