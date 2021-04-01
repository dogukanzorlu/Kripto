defmodule Kripto.MarketTest do
  use Kripto.DataCase

  alias Kripto.Market

  describe "cryptos" do
    alias Kripto.Market.Crypto

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def crypto_fixture(attrs \\ %{}) do
      {:ok, crypto} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Market.create_crypto()

      crypto
    end

    test "list_cryptos/0 returns all cryptos" do
      crypto = crypto_fixture()
      assert Market.list_cryptos() == [crypto]
    end

    test "get_crypto!/1 returns the crypto with given id" do
      crypto = crypto_fixture()
      assert Market.get_crypto!(crypto.id) == crypto
    end

    test "create_crypto/1 with valid data creates a crypto" do
      assert {:ok, %Crypto{} = crypto} = Market.create_crypto(@valid_attrs)
    end

    test "create_crypto/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Market.create_crypto(@invalid_attrs)
    end

    test "update_crypto/2 with valid data updates the crypto" do
      crypto = crypto_fixture()
      assert {:ok, %Crypto{} = crypto} = Market.update_crypto(crypto, @update_attrs)
    end

    test "update_crypto/2 with invalid data returns error changeset" do
      crypto = crypto_fixture()
      assert {:error, %Ecto.Changeset{}} = Market.update_crypto(crypto, @invalid_attrs)
      assert crypto == Market.get_crypto!(crypto.id)
    end

    test "delete_crypto/1 deletes the crypto" do
      crypto = crypto_fixture()
      assert {:ok, %Crypto{}} = Market.delete_crypto(crypto)
      assert_raise Ecto.NoResultsError, fn -> Market.get_crypto!(crypto.id) end
    end

    test "change_crypto/1 returns a crypto changeset" do
      crypto = crypto_fixture()
      assert %Ecto.Changeset{} = Market.change_crypto(crypto)
    end
  end
end
