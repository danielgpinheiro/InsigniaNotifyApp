defmodule InsigniaNotifyAppWeb.TokenController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyApp.Token

  # def change_token(params) do
  #   case Token.get_by(params.user_id) do
  #     {:error, :not_found} ->
  #       Token.create(params)

  #     {:ok, tokens} ->
  #       Token.update(tokens, params)
  #   end
  # end

  def check_token(old_token, current_token) do
    IO.inspect(old_token)
    IO.inspect(current_token)

    if old_token != current_token and old_token != "null" do
      case Token.get_by_old_token(old_token) do
        {:error, :not_found} ->
          {:update, nil}

        {:ok, user} ->
          Token.update(user, %{
            old_token: current_token,
            user_token: current_token
          })

          {:update, user.id}
      end
    else
      case Token.get_by(current_token) do
        {:error, :not_found} ->
          {_, user_created} =
            Token.create(%{
              user_token: current_token,
              old_token: old_token
            })

          {:ok, user_created.id}

        {:ok, user} ->
          if user.user_token != current_token do
            Token.update(user, %{
              user_token: current_token
            })
          end

          {:ok, user.id}
      end
    end
  end

  def get_all() do
    Token.get_all()
  end
end
