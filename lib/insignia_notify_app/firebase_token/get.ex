defmodule InsigniaNotifyApp.FirebaseToken.Get do
  alias InsigniaNotifyApp.FirebaseToken.Token
  alias InsigniaNotifyApp.Repo

  def call(user_id) do
    case Repo.get_by(Token, user_id: user_id) do
      nil -> {:error, :not_found}
      firebase_token -> {:ok, firebase_token}
    end
  end

  def call2() do
    case Repo.all(Token) do
      nil -> {:error, :not_found}
      firebase_tokens -> {:ok, firebase_tokens}
    end
  end
end
