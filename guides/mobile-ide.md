# モバイルアプリ開発の IDE 推奨

モバイルアプリを開発する場合、**プロジェクト自体は専用 IDE から開く** ことを強く推奨します。Claude Code でもコードは書けますが、**ビルド・シミュレータ起動・実機デバッグ・UI プレビュー・証明書管理** などはネイティブ IDE が圧倒的に便利です。

## プラットフォーム別の推奨 IDE

| プラットフォーム | 推奨 IDE | 公式ダウンロード |
| --- | --- | --- |
| iOS / macOS (Swift / SwiftUI) | **Xcode** | <https://developer.apple.com/xcode/> |
| Android (Kotlin / Jetpack Compose) | **Android Studio** | <https://developer.android.com/studio> |
| Flutter (iOS + Android) | Android Studio または VS Code + Flutter 拡張 | <https://flutter.dev/> |
| React Native (iOS + Android) | VS Code + React Native 拡張 | <https://reactnative.dev/> |
| Kotlin Multiplatform (KMP) | Android Studio + KMP プラグイン | <https://kotlinlang.org/docs/multiplatform.html> |

## おすすめの使い分け

1. **プロジェクトの新規作成** → **必ず専用 IDE で行う**。`flutter create`, Xcode の「New Project」, Android Studio の「New Project」など。Claude Code はプロジェクトを生成しません
2. **コードを書く・仕様書を作る・テストを追加する** → Claude Code（このプラグイン）で進める
3. **動作確認 (シミュレータ・実機での起動)** → **専用 IDE から起動** が推奨。`/cc-development-team:develop` の Step 5 でも、Mobile プロジェクトでは「IDE を開いて Run してください」と案内されます

> **Web との違い:** Web は Claude が `npm run dev` 等でローカル dev server を立ち上げて URL を案内します。Mobile は **ビルド・シミュレータ管理・証明書・実機デバッグ・UI プレビュー** が IDE に集約されており、CLI 起動は最終手段です。

## プラグインの動作

プラグインの `/cc-development-team:init-dept` でプロジェクト種別「Mobile」を選ぶと、まず **「プロジェクトを専用 IDE で作成済みか?」を確認** します:

- **作成済み** → そのまま設計思想 / コード配置のヒアリングに進む
- **これから作る** → init-dept を一旦止めて、IDE での作成を案内してから終了。プロジェクトが立ち上がったら再実行を促す
- **IDE は使わない (上級者向け)** → そのまま進めるが、動作確認は CLI のみ

`/cc-development-team:develop` の動作確認ステップでも、Mobile プロジェクトでは Xcode / Android Studio / Flutter IDE / RN IDE での起動手順を案内します。ユーザーが明示的に「CLI で起動して」と言った場合のみ `xcrun` / `gradlew` 等を実行します。
