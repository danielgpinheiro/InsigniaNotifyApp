defmodule InsigniaNotifyAppWeb.FilterController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyApp.Filters

  def change_order_by(params) do
    case Filters.get_by(params.user_id) do
      {:error, :not_found} ->
        Filters.create(params)

      {:ok, filters} ->
        Filters.update(filters, params)
    end
  end

  def get_order_by_preferences_by_user_id(user_id) do
    Filters.get_by(user_id)
  end
end
