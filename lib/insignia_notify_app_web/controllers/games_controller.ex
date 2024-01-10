defmodule InsigniaNotifyAppWeb.GamesController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyAppWeb.Http.Api

  def get_stats() do
    {_, job_url} = System.fetch_env("JOB_URL")

    case Api.get("#{job_url}/api/stats") do
      {:ok, body} ->
        json = Jason.decode!(body)

        {:ok, convert_json_to_map_with_atoms(json["stats"])}

      {:error, _} ->
        {:error, :internal_server_error}
    end
  end

  def get_games do
    {_, job_url} = System.fetch_env("JOB_URL")

    case Api.get("#{job_url}/api/games") do
      {:ok, body} ->
        json = Jason.decode!(body)

        json["games"]
        |> Enum.map(fn game ->
          convert_json_to_map_with_atoms(game)
        end)

      {:error, _} ->
        {:error, :internal_server_error}
    end
  end

  def get_game_matches(url) do
    {_, job_url} = System.fetch_env("JOB_URL")

    case Api.get("#{job_url}/api/game_match?url=#{url}") do
      {:ok, body} ->
        json = Jason.decode!(body)

        matches =
          convert_json_to_map_with_atoms(json)

      {:error, _} ->
        {:error, :internal_server_error}
    end
  end

  defp convert_json_to_map_with_atoms(json) do
    Enum.reduce(json, %{}, fn {key, val}, acc ->
      Map.put(acc, String.to_atom(key), val)
    end)
  end
end
