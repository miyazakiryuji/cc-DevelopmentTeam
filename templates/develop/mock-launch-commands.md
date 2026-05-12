<!--
このファイルは /cc-development-team:develop の Step 5 (モック起動の確認) で、
ユーザーが yes を選んだ時に Read します。
プラットフォーム別の具体的な起動コマンドの参照表です。
-->

# モック起動 — プラットフォーム別の具体コマンド

ユーザーが「yes」を選んだら、以下のフォーマットで **最終確認** を取った上で、対応するプラットフォームのコマンドを実行する。

```
以下のコマンドを実行します。OK ですか?
  <コマンド>

(注意: dev server / シミュレータはバックグラウンドで動き続けます。停止方法は後ほどお伝えします)
```

確認が取れたら、以下のルールで実行:

## Web の場合
- `Bash` を `run_in_background: true` で実行
- 数秒待ってから、ログを確認してアクセス URL を抽出（"localhost:3000" 等）
- ユーザーに `「http://localhost:XXXX で起動しました。停止するときは別ターミナルで kill <PID> または該当プロセスを Ctrl+C」` と伝える

## iOS の場合
- `xcrun simctl boot <デバイス名>` (例: `xcrun simctl boot 'iPhone 15'`) をフォアグラウンドで実行
- `xcrun simctl list devices` で利用可能デバイスを確認するのが安全
- `xcodebuild` でビルド + シミュレータインストール、または Xcode を `open` で起動する案内
- シミュレータの起動完了を待ってから、`xcrun simctl launch booted <bundle-id>` でアプリを起動

## Android の場合
- `emulator -list-avds` で利用可能なエミュレータ確認
- `emulator -avd <名前>` をバックグラウンドで起動
- 起動完了を `adb wait-for-device` で待ってから、`./gradlew installDebug` でビルド+インストール
- `adb shell am start -n <package>/<activity>` でアプリ起動

## Flutter の場合
- `flutter run` を `run_in_background: true` で実行
- デバイス選択が必要なら事前に `flutter devices` で確認

## React Native の場合
- `npx react-native run-ios` または `run-android` を `run_in_background: true` で実行

## 起動後の取り扱い (全プラットフォーム共通)

- 起動したプロセスの PID または識別情報を保持し、ユーザーに伝える
- develop モードのサイクルを続ける場合、次の依頼の処理は通常通り継続（dev server はそのまま動かしておく）
- HMR (Hot Module Reload) があれば修正は自動反映される旨を伝える
- 大きな修正後は再起動が必要かもしれないことを案内

## 「別のコマンドで」を選ばれた場合

ユーザーに「どのコマンドで起動しますか?」と尋ね、回答に従って同様に最終確認 → 実行。

## 「no」を選ばれた場合

「起動はスキップしました。後で確認する場合は手動で `<コマンド>` を実行してください」と伝えて、次の Step (完了報告) へ。
