# architect 部署 — プロジェクト固有メモ (Web)

このファイルは architect サブエージェントが起動時に読み込みます。
Web 開発向けの設計判断ガイドをここに書いてください。

## プロジェクト概要
- 種別: Web
- フロントエンド / バックエンド / フルスタック: <埋める>
- 主要フレームワーク: <Next.js / Nuxt / Django / Rails / Express など>
- 言語: <TypeScript / Python / Go / Ruby など>

## アーキテクチャ方針
- レンダリング戦略: <SPA / SSR / SSG / ISR>
- コンポーネント設計の方針（Atomic / Feature-based 等）
- データフロー / 状態管理（Redux / Zustand / React Query 等）
- API 設計: <REST / GraphQL / tRPC>
- 認証方式: <セッション / JWT / OAuth>

## ドメイン用語集
- ドメイン固有の語彙と定義

## 非機能要件
- 性能: 初期表示時間・API レスポンスタイム目標
- アクセシビリティ: WCAG 準拠レベル
- ブラウザ対応: Chrome / Safari / Edge / Firefox の最小バージョン
- セキュリティ: OWASP 重点項目（XSS / CSRF / SQL injection 等）
- SEO 要件: 必要な範囲

## 設計判断の前例集
- 過去に下した重要な設計判断と、その理由
