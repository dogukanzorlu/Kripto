defmodule Kripto.Market.Crypto.Api do
    @url "https://api.lunarcrush.com/v2?data=market&type=fast&key="
    @key System.get_env("LUNAR_API_KEY")

    def fetch() do
      with {:ok, %Finch.Response{body: body, status: 200}} <- request(),
           {:ok, response} <- parse(body),
           {:ok, data} <- body(response) do
        {:ok, data}
      else
        _ -> {:error, %{}}
      end
    end

    def build() do
      Finch.build(
        :get,
        "#{@url}#{@key}"
      )
    end

    def request() do
      Finch.request(build(), KriptoFinch)
    end

    def parse(body), do: Jason.decode(body)

    def body(%{"data" => data}) do
      {:ok,
     %{
       "data" => data
      }}
    end
end
