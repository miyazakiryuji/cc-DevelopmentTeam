# 関数ドキュメントコメント — R (roxygen2)

developer エージェントが docstring を書くときに Read します。
(主ファイル: agents/developer.md「関数のドキュメントコメント」セクション参照)


```r
#' 注文 ID から請求書 PDF を生成して S3 に保存する。
#'
#' @param order_id 注文の一意 ID (UUID v4) を表す文字列。
#' @param locale PDF の言語 ("ja" または "en")。デフォルトは "ja"。
#' @return 保存された S3 オブジェクトキー (character)。
#' @seealso docs/specs/invoice-export.md
#' @examples
#' generate_invoice("abc-123", locale = "en")
#' @export
generate_invoice <- function(order_id, locale = "ja") { ... }
```

