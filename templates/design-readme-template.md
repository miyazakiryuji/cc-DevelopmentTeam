# デザイン格納フォルダ

このフォルダは、プロジェクトの **デザイン関連ファイル** を置く場所です。
コードではなく、画像・モックアップ・スタイルガイドなど「見た目に関する素材」をまとめて管理します。

## ディレクトリ構成

```
design/
├── README.md           # このファイル
├── mockups/            # 画面モックアップ (Figma エクスポート / PNG / JPG / PDF 等)
├── wireframes/         # ワイヤーフレーム (粗い構造図)
├── assets/             # ロゴ・アイコン・画像素材 (デザインソース)
└── style-guide.md      # デザイントークン (カラー / タイポグラフィ / 余白 / コンポーネント方針)
```

各サブフォルダは **必要になってから埋めれば OK** です。空のままでも問題ありません。

## どこに何を入れるか

| 場所 | 入れるもの | 例 |
| --- | --- | --- |
| `mockups/` | 画面の完成イメージ | `login-screen.png`, `home-mockup.fig`, `Figma エクスポート.pdf` |
| `wireframes/` | 構造重視の粗いラフ | `login-wireframe.png`, `flow-rough-v1.pdf` |
| `assets/` | ロゴ・アイコン・素材 (ソース) | `logo.svg`, `app-icon-1024.png`, `illustrations/` |
| `style-guide.md` | デザイントークン / コンポーネント方針 | カラーパレット、フォント、余白ルール |

## 設計ドキュメントとの関係

- **画面遷移図の俯瞰** → `docs/basic-design/basic-design.md` (全体設計) に記載
- **個別画面のレイアウト詳細** → `docs/specs/<feature-name>.md` (個別設計) に記載
- **画面のビジュアルイメージ** → このフォルダ (`design/mockups/`) に置く

仕様書から画像を参照する場合は、相対パスで `../../design/mockups/<file>.png` のようにリンクしてください。

## style-guide.md のテンプレート

```markdown
# スタイルガイド

## カラーパレット
- Primary: #...
- Secondary: #...
- Success / Warning / Error / Info: ...

## タイポグラフィ
- フォントファミリー: ...
- 見出し H1 / H2 / H3 のサイズ
- 本文 body のサイズと行間

## 余白・グリッド
- 基本単位: 4px or 8px
- コンテナの最大幅 / ガター

## コンポーネント方針
- ボタンの状態 (default / hover / active / disabled)
- フォーム部品の高さ / 角丸
- カードの影 / 角丸 / 余白
```

## アセット管理のコツ

- **ファイル名は kebab-case** で（例: `login-screen-v2.png`）
- **本番ビルドに含める画像** はソースコード側（例: `public/`, `assets/`）に別途配置し、ここはあくまで **デザインソース** の置き場
- Figma などの共有リンクがある場合は `mockups/README.md` に URL をまとめておくと便利
- バージョン管理する画像が増えそうなら Git LFS を検討
