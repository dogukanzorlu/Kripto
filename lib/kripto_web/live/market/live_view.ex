defmodule KriptoWeb.Market.LiveView do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    if connected?(socket), do: KriptoWeb.Endpoint.subscribe("market")
    {:ok, init_rates(socket)}
  end

  def handle_info(%{event: "rates", payload: rates}, socket) do
    {:noreply, assign(socket, rates: rates, updated_at: NaiveDateTime.local_now())}
  end

  def init_rates(socket) do
    {_, rates} = Kripto.Market.Crypto.Api.fetch()
    assign(socket, rates: rates, updated_at: NaiveDateTime.local_now())
  end
end
