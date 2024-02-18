defmodule InsigniaNotifyAppWeb.Http.Api do
  alias InsigniaNotifyAppWeb.Http.HandleResponse

  def get(base_url) do
    case HTTPoison.get(base_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        HandleResponse.response(:ok, body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        HandleResponse.response(:error, :not_found)

      {:ok, %HTTPoison.Response{status_code: 500}} ->
        HandleResponse.response(:error, :internal_server_error)

      {:error, %HTTPoison.Error{reason: reason}} ->
        HandleResponse.response(:error, reason)
    end
  end

  def post(base_url, body, headers) do
    case HTTPoison.post(base_url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        HandleResponse.response(:ok, body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        HandleResponse.response(:error, :not_found)

      {:ok, %HTTPoison.Response{status_code: 500}} ->
        HandleResponse.response(:error, :internal_server_error)

      {:error, %HTTPoison.Error{reason: reason}} ->
        HandleResponse.response(:error, reason)
    end
  end
end
