# Minecraft PVP Datapack

Minecraft 1.20.1 用のカスタム PVP データパック。
役職システム（Mechanic / Ninja / Samurai）を軸にした戦略的な対戦モードを実装。

---

## 📦 概要

このデータパックは、特殊能力を持つ役職が割り当てられたプレイヤー同士で対戦するPVPゲームモードです。

### 実装済み役職

| 役職 | 特徴 | 主なアビリティ |
|------|------|---------------|
| **Mechanic** | ガジェットを設置して戦う | タレット、地雷、ランチャー、スネア、修理 |
| **Ninja** | 高機動＋ステルス戦闘に特化 | 影縫い、変わり身、煙玉 |
| **Samurai** | - | - |

---

## 📥 インストール方法

このデータパックをマインクラフトで使用するには、以下のパスにフォルダをコピーしてください：

```
C:\Users\<ユーザー名>\curseforge\minecraft\Instances\pvp\saves\<ワールド名>\datapacks
```

コピー後、マインクラフト内で `/reload` コマンドを実行してデータパックを読み込んでください。

---

## 🎮 ゲーム内コマンド

### 試合管理

```mcfunction
# 試合開始（役職ランダム割り当て＋タイマー起動）
/function my_pvp:system/game_start

# 試合終了（勝者判定＋リザルト表示）
/function my_pvp:system/game_end

# リセット（スコア・ガジェット全削除）
/function my_pvp:system/reset_game

# 初期セットアップ（スコアボード作成・初回のみ）
/function my_pvp:init/setup
```

### デバッグ用

```mcfunction
# Mechanic に強制変更（テスト用）
/function my_pvp:debug/mechanic

# Ninja に強制変更（テスト用）
/function my_pvp:debug/ninja
```

### その他

```mcfunction
# データパック再読み込み（変更を反映）
/reload
```


## 🗂️ プロジェクト構造

```
minecraft_pvp/
├── pack.mcmeta                 # データパックのメタ情報
├── README.md                   # このファイル
└── data/
    ├── minecraft/
    │   └── tags/
    │       └── functions/
    │           ├── load.json   # ワールド読み込み時に実行
    │           └── tick.json   # 毎tick実行
    └── my_pvp/
        ├── functions/
        │   ├── init/           # 初期化処理
        │   │   └── setup.mcfunction
        │   ├── main/           # メインループ
        │   │   ├── loop.mcfunction
        │   │   └── game_logic.mcfunction
        │   ├── system/         # システム管理
        │   │   ├── game_start.mcfunction
        │   │   ├── game_end.mcfunction
        │   │   ├── reset_game.mcfunction
        │   │   ├── assign_roles.mcfunction
        │   │   └── ...
        │   ├── roles/          # 役職別の処理
        │   │   ├── mechanic/   # メカニック関連
        │   │   ├── ninja/      # 忍者関連
        │   │   └── samurai/    # 侍関連（開発中）
        │   └── debug/          # デバッグ用
        └── predicates/
            └── is_sneaking.json
```

---

## 🛠️ 開発ワークフロー

### Issue / Project 管理

基本的には issue に自分をアサインしてから作業に取り掛かること。

- Issue にはタグをつけること
- Project のステータスを **To-do → 実装中** に変更
- 作業完了時：**実装完了** に変更し、Issue を **Closed** にする
- 新しい Issue を立てる時は必ず **Project への追加** を忘れないこと

### ブランチ命名規則

```
接頭辞/issue番号-内容-内容
```

内容はケバブケースを使用し、接頭辞には以下のような内容を使用すること。

| 接頭辞   | 内容                                                                                                                       |
| :------- | :------------------------------------------------------------------------------------------------------------------------- |
| fix      | 既存の機能の問題を修正する場合に使用します。                                                                               |
| hotfix   | 緊急の変更を追加する場合に使用します。                                                                                     |
| add      | 新しいファイルや機能を追加する場合に使用します。                                                                           |
| feat     | 新しい機能やファイルを追加する場合に使用します。                                                                           |
| update   | 既存の機能に問題がないが、修正を加えたい場合に使用します。                                                                 |
| change   | 仕様変更により、既存の機能に修正を加えた場合に使用します。                                                                 |
| refactor | コードを修正し、改善する場合に使用します。                                                                                 |
| improve  | コードの改善をする場合に使用します。                                                                                       |
| disable  | 機能を一時的に無効にする場合に使用します。                                                                                 |
| delete   | ファイルを削除する場合や、機能を削除する場合に使用します。                                                                 |
| rename   | ファイル名を変更する場合に使用します。                                                                                     |
| move     | ファイルを移動する場合に使用します。                                                                                       |
| upgrade  | バージョンをアップグレードする場合に使用します。                                                                           |
| revert   | 以前のコミットに戻す場合に使用します。                                                                                     |
| docs     | ドキュメントを修正する場合に使用します。                                                                                   |
| style    | コーディングスタイルの修正をする場合に使用します。                                                                         |
| perf     | コードのパフォーマンスを改善する場合に使用します。                                                                         |
| test     | テストコードを修正する場合や、テストコードを追加する場合に使用します。                                                     |
| chore    | ビルドツールやライブラリで自動生成されたものをコミットする場合や、上記の接頭辞に当てはまらない修正をする場合に使用します。 |

### コミット命名規則

基本何をやったか分かるような内容であれば構わない。
余裕があればブランチ命名規則同様に接頭辞を記載すること。

## Git 開発フロー（逐一守ること）

#### 1️⃣ Issue を立てる

- GitHub の [Issues](https://github.com/bututetu1-stack/minecraft_pvp/issues) から新規 Issue を作成
- **必ず Project に追加** すること
- 適切なラベル（タグ）を付ける

#### 2️⃣ Branch を立てる

```bash
# ブランチを作成して切り替え
git switch -c "接頭辞/issue番号-内容-内容"
```

✅ **命名規則をある程度守ること**（上記の接頭辞を参照）

例：
```bash
git switch -c "feat/issue12-add-samurai-role"
git switch -c "fix/issue34-mechanic-turret-bug"
```

#### 3️⃣ さぎょさぎょ

✅ **目的のブランチで作業しているか確認**

```bash
# 現在のブランチを確認
git branch --show-current
```

#### 4️⃣ Add（ステージング）

```bash
# 変更をステージングに追加
git add .
```

✅ **不必要なファイルを削除してから add すること**
- 一時ファイル、テスト用ファイルなどは除外

#### 5️⃣ Commit

```bash
# コミット（メッセージは分かりやすく）
git commit -m "どこを修正・加筆したのかを書く"
```

✅ コミットメッセージの注意点：
- ❌ **NG例：** `"頑張った"`、`"作業完了"`（感想は書かない）
- ✅ **OK例：** `"feat: Samuraiの基本スキルを実装"`、`"fix: Mechanicのタレット範囲攻撃バグを修正"`

#### 6️⃣ さぎょさぎょ（続き）

Issue を満たせたら次へ進む

#### 7️⃣ Push

```bash
# リモートリポジトリにプッシュ
git push origin ブランチ名
```

例：
```bash
git push origin feat/issue12-add-samurai-role
```

#### 8️⃣ Pull Request（プルリク）

1. GitHub の [Pull Requests](https://github.com/bututetu1-stack/minecraft_pvp/pulls) タブを開く
2. **"New pull request"** をクリック
3. 設定：
   - ✅ **Assignee を自分自身に設定**
   - ✅ **Development タブで Issue とプルリクを紐づけ**
   - タイトルと説明を記入（何を変更したか、どの Issue に対応しているか）

#### 9️⃣ Merge

1. プルリクのレビュー・チェック
2. 問題がないことを確認したら **Merge** する
3. Issue が自動で Close されることを確認（紐づけしていれば）

---
