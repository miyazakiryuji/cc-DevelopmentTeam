# 関数ドキュメントコメント — Elixir (`@doc`)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```elixir
@doc """
注文 ID から請求書 PDF を生成して S3 に保存する。

## Parameters
  - `order_id` — 注文の一意 ID (UUID v4)
  - `locale` — PDF の言語 (`:ja` | `:en`、デフォルト `:ja`)

## Returns
  - `{:ok, key}` — 保存された S3 オブジェクトキー
  - `{:error, reason}` — `:order_not_found` | `:storage_write_failed`

## See
  - `docs/specs/invoice-export.md`

## Examples
    iex> generate_invoice("abc-123", locale: :en)
    {:ok, "invoices/abc-123.pdf"}
"""
@spec generate_invoice(String.t(), keyword()) :: {:ok, String.t()} | {:error, atom()}
def generate_invoice(order_id, opts \\ []), do: ...
```

