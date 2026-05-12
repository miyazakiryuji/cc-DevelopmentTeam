# architect 部署 — プロジェクト固有メモ (Mobile)

このファイルは architect サブエージェントが起動時に読み込みます。
Mobile 開発向けの設計判断ガイドをここに書いてください。

## プロジェクト概要
- 種別: Mobile
- プラットフォーム: <iOS / Android / クロスプラットフォーム>
- 主要フレームワーク: <SwiftUI / UIKit / Jetpack Compose / Flutter / React Native / KMP>
- 言語: <Swift / Kotlin / Dart など>

## サポート対象
- iOS 最小バージョン: <iOS 16 など>
- Android 最小 API レベル: <API 26 など>
- 端末対応: 画面サイズ・縦横切替・ダークモード

## アーキテクチャ方針
- パターン: <MVVM / MVI / TCA / Clean Architecture>
- ナビゲーション: <NavigationStack / Jetpack Navigation / Coordinator>
- 状態管理: <Observable / Flow / Compose State>
- DI: <Hilt / Koin / Swinject / 手書き>

## ドメイン用語集
- ドメイン固有の語彙と定義

## 非機能要件
- 性能: 起動時間（cold start）、画面遷移、FPS 目標
- アクセシビリティ: VoiceOver / TalkBack 対応、Dynamic Type
- オフライン対応: 必要な範囲、データキャッシュ戦略
- 通知: Push 通知の利用範囲、バックグラウンド処理
- セキュリティ: Keychain / Keystore の使い方、証明書ピンニング、難読化
- ストア対応: App Store / Play Store の審査ガイドライン上の留意点

## 設計判断の前例集
- 過去に下した重要な設計判断と、その理由
