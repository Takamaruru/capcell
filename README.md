# Capcell

Flutterで開発されたプロジェクト管理アプリケーション

## 概要

Capcellは、プロジェクトを視覚的に管理できるmacOS/Windowsデスクトップアプリケーションです。グリッドビューでプロジェクト一覧を表示し、ツリービューで階層構造を管理できます。

## 主な機能

- **プロジェクト一覧表示**: グリッド形式で複数のプロジェクトを見やすく表示
- **ツリービュー**: プロジェクトの階層構造を視覚的に管理
- **インタラクティブな編集**: ホバー時にノードの追加ボタンを表示
- **macOS UI**: macOS用に最適化されたネイティブなUI

## 必要環境

- Flutter SDK 3.7.2以上
- macOS 10.13以上 または Windows
- Dart 3.7.2以上

## セットアップ

1. リポジトリをクローン
```bash
git clone <repository-url>
cd capcell
```

2. 依存関係をインストール
```bash
flutter pub get
```

3. アプリを実行
```bash
# macOS
flutter run -d macos

# Windows
flutter run -d windows
```

## ビルド

```bash
# macOS用リリースビルド
flutter build macos --release

# Windows用リリースビルド
flutter build windows --release
```

## テスト

```bash
flutter test
```

## プロジェクト構成

- `lib/main.dart` - アプリケーションのエントリーポイントとメインUI
- `lib/grid_page.dart` - プロジェクト一覧グリッドビュー
- `lib/tree_view.dart` - ツリービューとノード管理
- `lib/function.dart` - 共通機能とユーティリティ

## 技術スタック

- **Flutter**: クロスプラットフォームUIフレームワーク
- **macos_ui**: macOS用UIコンポーネント
- **graphview**: グラフとツリー構造の可視化
- **provider**: 状態管理

## ライセンス

このプロジェクトはプライベートプロジェクトです。
