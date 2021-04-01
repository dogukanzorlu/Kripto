defmodule Kripto.Market.Crypto.Socket do
  use GenServer

  require Logger

  alias Kripto.Market.Crypto.Api

  @timeout 20000

  def start_link(default \\ %{}) do
    GenServer.start_link(__MODULE__, default)
  end

  @spec init(any) :: {:ok, {:error, %{}} | {:ok, %{optional(<<_::32>>) => any}}, 20000}
  def init(_state \\ %{}) do
    {:ok, Api.fetch(), @timeout}
  end

  def handle_info(:timeout, _state) do
    Logger.info("Fetching Market....")
    {_, rates} = Api.fetch()
    KriptoWeb.Endpoint.broadcast("market", "rates", rates)
    {:noreply, rates, @timeout}
  end
end
