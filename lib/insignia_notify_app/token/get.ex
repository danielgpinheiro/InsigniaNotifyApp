defmodule InsigniaNotifyApp.Token.Get do
  alias InsigniaNotifyApp.Token.Token
  alias InsigniaNotifyApp.Repo

  def get_by(token) do
    case Repo.get_by(Token, user_token: token) do
      nil -> {:error, :not_found}
      token -> {:ok, token}
    end
  end

  def get_by_old_token(token) do
    case Repo.get_by(Token, old_token: token) do
      nil -> {:error, :not_found}
      token -> {:ok, token}
    end
  end

  def get_all() do
    case Repo.all(Token) do
      nil -> {:error, :not_found}
      tokens -> {:ok, tokens}
    end
  end
end
