defmodule KriptoWeb.CryptoLiveTest do
  use KriptoWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Kripto.Market

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:crypto) do
    {:ok, crypto} = Market.create_crypto(@create_attrs)
    crypto
  end

  defp create_crypto(_) do
    crypto = fixture(:crypto)
    %{crypto: crypto}
  end

  describe "Index" do
    setup [:create_crypto]

    test "lists all cryptos", %{conn: conn, crypto: crypto} do
      {:ok, _index_live, html} = live(conn, Routes.crypto_index_path(conn, :index))

      assert html =~ "Listing Cryptos"
    end

    test "saves new crypto", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.crypto_index_path(conn, :index))

      assert index_live |> element("a", "New Crypto") |> render_click() =~
               "New Crypto"

      assert_patch(index_live, Routes.crypto_index_path(conn, :new))

      assert index_live
             |> form("#crypto-form", crypto: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#crypto-form", crypto: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.crypto_index_path(conn, :index))

      assert html =~ "Crypto created successfully"
    end

    test "updates crypto in listing", %{conn: conn, crypto: crypto} do
      {:ok, index_live, _html} = live(conn, Routes.crypto_index_path(conn, :index))

      assert index_live |> element("#crypto-#{crypto.id} a", "Edit") |> render_click() =~
               "Edit Crypto"

      assert_patch(index_live, Routes.crypto_index_path(conn, :edit, crypto))

      assert index_live
             |> form("#crypto-form", crypto: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#crypto-form", crypto: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.crypto_index_path(conn, :index))

      assert html =~ "Crypto updated successfully"
    end

    test "deletes crypto in listing", %{conn: conn, crypto: crypto} do
      {:ok, index_live, _html} = live(conn, Routes.crypto_index_path(conn, :index))

      assert index_live |> element("#crypto-#{crypto.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#crypto-#{crypto.id}")
    end
  end

  describe "Show" do
    setup [:create_crypto]

    test "displays crypto", %{conn: conn, crypto: crypto} do
      {:ok, _show_live, html} = live(conn, Routes.crypto_show_path(conn, :show, crypto))

      assert html =~ "Show Crypto"
    end

    test "updates crypto within modal", %{conn: conn, crypto: crypto} do
      {:ok, show_live, _html} = live(conn, Routes.crypto_show_path(conn, :show, crypto))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Crypto"

      assert_patch(show_live, Routes.crypto_show_path(conn, :edit, crypto))

      assert show_live
             |> form("#crypto-form", crypto: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#crypto-form", crypto: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.crypto_show_path(conn, :show, crypto))

      assert html =~ "Crypto updated successfully"
    end
  end
end
