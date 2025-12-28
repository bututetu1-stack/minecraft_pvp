# 役職追加ガイド

このドキュメントでは、新しい役職（ロール）を追加する際に必要な手順と変更が必要なファイルをまとめています。

---

## 📁 新規作成が必要なファイル

新しい役職を追加する場合、以下のファイル・フォルダを作成する必要があります。

### 1. 役職フォルダ (`data/my_pvp/functions/roles/<role_name>/`)

役職ごとの処理ファイルを格納するフォルダです。

| ファイル名 | 説明 | 必須 |
|-----------|------|:----:|
| `assign.mcfunction` | 役職割り当て時の初期化処理（タグ付け、通知、ステータス設定） | ✅ |
| `<role_name>_main.mcfunction` | 毎ティック実行されるメイン処理（クールダウン管理、常時効果など） | ✅ |
| `scan_items.mcfunction` | ドロップアイテムの検知・処理の振り分け | ✅ |
| `process_<item>.mcfunction` | 各アイテム使用時の処理（スキルの数だけ作成） | ⚪ |
| その他 | 役職固有の機能に応じた追加ファイル | ⚪ |

#### 参考：既存役職のファイル構成例（バーサーカー）

```
roles/berserker/
├── assign.mcfunction          # 役職割り当て
├── apply_status.mcfunction    # ステータス設定
├── berserker_main.mcfunction  # メインループ
├── scan_items.mcfunction      # アイテム検知
├── process_axe.mcfunction     # ブラッドアックス処理
├── process_raid.mcfunction    # ブラッドクリスタル処理
├── process_feather.mcfunction # リープフェザー処理
├── check_slam.mcfunction      # ジャンプ着地監視
└── slam_impact.mcfunction     # 着地衝撃波
```

### 2. デバッグファイル (`data/my_pvp/functions/debug/<role_name>.mcfunction`)

開発・テスト用のファイルです。実行するとその役職に即座になれます。

```mcfunction
# 例: debug/berserker.mcfunction

# 1. 既存のアイテムと役職タグを消す
clear @s
tag @s remove mechanic
tag @s remove ninja
tag @s remove scout
tag @s remove tank
tag @s remove berserker
tag @s remove <new_role>  # ← 新役職も追加
tag @s remove role_assigned

# IDがない場合は付与する
execute unless score @s player_id matches 1.. run function my_pvp:system/assign_new_id

# 2. 役職に任命
function my_pvp:roles/<role_name>/assign

# 3. アイテム配布
function my_pvp:system/give_<role_name>_items

# 4. アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"<役職名>に変更しました","color":"<color>"}]
```

### 3. アイテム配布ファイル (`data/my_pvp/functions/system/give_<role_name>_items.mcfunction`)

役職固有のアイテムを配布する処理です。

```mcfunction
# 例: system/give_berserker_items.mcfunction

# 武器・スキルアイテムをスロットに配置
item replace entity @s container.0 with minecraft:iron_axe{custom_tag:1b,...} 1
item replace entity @s container.1 with minecraft:feather{custom_tag:1b,...} 1
item replace entity @s container.2 with minecraft:red_dye{custom_tag:1b,...} 1
```

---

## 📝 変更が必要な既存ファイル

### 1. `data/my_pvp/functions/system/init_role_deck.mcfunction`

役職抽選用のカード（くじ）を追加します。

```diff
 # 既存のくじ
 summon marker ~ ~ ~ {Tags:["role_card","card_mechanic"]}
 summon marker ~ ~ ~ {Tags:["role_card","card_ninja"]}
 summon marker ~ ~ ~ {Tags:["role_card","card_scout"]}
 summon marker ~ ~ ~ {Tags:["role_card","card_tank"]}
 summon marker ~ ~ ~ {Tags:["role_card","card_berserker"]}
+# 【追加】新役職のくじ
+summon marker ~ ~ ~ {Tags:["role_card","card_<role_name>"]}
```

### 2. `data/my_pvp/functions/system/distribute_role.mcfunction`

抽選結果に基づいて役職を割り当てる処理を追加します。

```diff
 # 既存の分岐
 execute if entity @e[tag=selected_card,tag=card_mechanic] run function my_pvp:roles/mechanic/assign
 execute if entity @e[tag=selected_card,tag=card_ninja] run function my_pvp:roles/ninja/assign
 execute if entity @e[tag=selected_card,tag=card_scout] run function my_pvp:roles/scout/assign
 execute if entity @e[tag=selected_card,tag=card_tank] run function my_pvp:roles/tank/assign
 execute if entity @e[tag=selected_card,tag=card_berserker] run function my_pvp:roles/berserker/assign
+# 【追加】新役職のカードだった場合
+execute if entity @e[tag=selected_card,tag=card_<role_name>] run function my_pvp:roles/<role_name>/assign
```

### 3. `data/my_pvp/functions/main/game_logic.mcfunction`

毎ティック実行されるメイン処理に、新役職の処理を追加します。

```diff
 # --- 1. プレイヤーの処理 ---
 execute as @a[tag=mechanic] at @s run function my_pvp:roles/mechanic/mechanic_main
 execute as @a[tag=ninja] at @s run function my_pvp:roles/ninja/ninja_main
 execute as @a[tag=scout] at @s run function my_pvp:roles/scout/scout_main
 execute as @a[tag=tank] at @s run function my_pvp:roles/tank/tank_main
 execute as @a[tag=berserker] at @s run function my_pvp:roles/berserker/berserker_main
+# 【追加】新役職のメイン処理
+execute as @a[tag=<role_name>] at @s run function my_pvp:roles/<role_name>/<role_name>_main

 # --- 2. アイテム処理（常時監視） ---
 execute as @e[type=item] at @s run function my_pvp:roles/mechanic/scan_items
 execute as @e[type=item] at @s run function my_pvp:roles/ninja/scan_items
 execute as @e[type=item] at @s run function my_pvp:roles/scout/scan_items
 execute as @e[type=item] at @s run function my_pvp:roles/tank/scan_items
 execute as @e[type=item] at @s run function my_pvp:roles/berserker/scan_items
+# 【追加】新役職のアイテムスキャン
+execute as @e[type=item] at @s run function my_pvp:roles/<role_name>/scan_items
```

### 4. `data/my_pvp/functions/system/start_sequence.mcfunction`

試合開始時のアナウンスとアイテム配布を追加します。

```diff
 # 役職ごとのサブタイトル
 execute as @a[tag=mechanic] run title @s subtitle {"text":"ガジェットを駆使して戦場を支配せよ","color":"gold"}
 execute as @a[tag=ninja] run title @s subtitle {"text":"変幻自在の忍術で敵を翻弄せよ","color":"dark_purple"}
 execute as @a[tag=scout] run title @s subtitle {"text":"ワイヤーを操り、戦場を縦横無尽に駆け巡れ","color":"aqua"}
 execute as @a[tag=tank] run title @s subtitle {"text":"歩く要塞となり、戦場を蹂躙せよ","color":"dark_green"}
 execute as @a[tag=berserker] run title @s subtitle {"text":"血を捧げ、敵を粉砕せよ","color":"red"}
+# 【追加】新役職のサブタイトル
+execute as @a[tag=<role_name>] run title @s subtitle {"text":"<キャッチコピー>","color":"<color>"}

 # --- 3. アイテム配布 ---
 execute as @a[tag=mechanic] run function my_pvp:system/give_mechanic_items
 execute as @a[tag=ninja] run function my_pvp:system/give_ninja_items
 execute as @a[tag=scout] run function my_pvp:system/give_scout_items
 execute as @a[tag=tank] run function my_pvp:system/give_tank_items
 execute as @a[tag=berserker] run function my_pvp:system/give_berserker_items
+# 【追加】新役職へのアイテム配布
+execute as @a[tag=<role_name>] run function my_pvp:system/give_<role_name>_items
```

### 5. `data/my_pvp/functions/system/reset_game.mcfunction`

ゲームリセット時のスコアとタグのクリア処理を追加します。

```diff
 # クールダウン系リセット
 scoreboard players reset * cd_turret
 ...
 scoreboard players reset * cd_ber_raid
 scoreboard players reset * cd_ber_jump
+# 【追加】新役職のCTリセット
+scoreboard players reset * cd_<role_name>_skill1
+scoreboard players reset * cd_<role_name>_skill2

 # 役職タグリセット
 tag @a remove role_assigned
 tag @a remove mechanic
 tag @a remove ninja
 tag @a remove scout
 tag @a remove tank
 tag @a remove berserker
+# 【追加】新役職のタグ削除
+tag @a remove <role_name>
```

### 6. `data/my_pvp/functions/init/setup.mcfunction`

スコアボード（クールダウン等）の初期化を追加します。

```diff
 # バーサーカー用クールダウン
 scoreboard objectives add cd_ber_raid dummy "ブラッドレイドCT"
 scoreboard objectives add cd_ber_jump dummy "ジャンプCT"
+
+# 【追加】新役職用クールダウン
+scoreboard objectives add cd_<role_name>_skill1 dummy "<スキル1名>CT"
+scoreboard objectives add cd_<role_name>_skill2 dummy "<スキル2名>CT"
+
+# 【追加】新役職用スキル検知（必要な場合）
+scoreboard objectives add click_<role_name> minecraft.used:minecraft.<item> "<スキル名>"
```

### 7. 既存のデバッグファイル（全役職分）

他役職のデバッグファイルにも新役職のタグ削除を追加します。

```diff
 # 1. 既存のアイテムと役職タグを消す
 tag @s remove mechanic
 tag @s remove ninja
 tag @s remove scout
 tag @s remove tank
 tag @s remove berserker
+tag @s remove <new_role>
```

対象ファイル：
- `debug/mechanic.mcfunction`
- `debug/ninja.mcfunction`
- `debug/scout.mcfunction`
- `debug/tank.mcfunction`
- `debug/berserker.mcfunction`

---

## ✅ チェックリスト

新役職を追加する際は、以下のチェックリストを使用してください。

### 新規作成
- [ ] `roles/<role_name>/assign.mcfunction` - 役職割り当て
- [ ] `roles/<role_name>/<role_name>_main.mcfunction` - メインループ
- [ ] `roles/<role_name>/scan_items.mcfunction` - アイテム検知
- [ ] `roles/<role_name>/process_*.mcfunction` - スキル処理（必要数）
- [ ] `system/give_<role_name>_items.mcfunction` - アイテム配布
- [ ] `debug/<role_name>.mcfunction` - デバッグ用

### 既存ファイル変更
- [ ] `system/init_role_deck.mcfunction` - くじ追加
- [ ] `system/distribute_role.mcfunction` - 抽選分岐追加
- [ ] `main/game_logic.mcfunction` - メイン処理追加
- [ ] `system/start_sequence.mcfunction` - 開始演出・配布追加
- [ ] `system/reset_game.mcfunction` - リセット処理追加
- [ ] `init/setup.mcfunction` - スコアボード追加
- [ ] `debug/*.mcfunction` - 全デバッグファイルにタグ削除追加

---

## 📌 命名規則

| 項目 | 形式 | 例 |
|------|------|-----|
| 役職タグ | `<role_name>` (小文字) | `berserker`, `ninja` |
| カードタグ | `card_<role_name>` | `card_berserker` |
| クールダウン | `cd_<role_prefix>_<skill>` | `cd_ber_raid`, `cd_ninja_swap` |
| アイテムNBT | `<role_name>_<item>:1b` | `berserker_axe:1b` |
| 関数名 | 小文字・アンダースコア | `berserker_main`, `process_raid` |

---

## 🔧 注意事項

1. **タグの一貫性**: `assign.mcfunction` で付与するタグと、他ファイルで参照するタグが一致していることを確認
2. **アイテムID管理**: `scan_items.mcfunction` では `player_id` を使って所有者を追跡している
3. **クールダウン管理**: `_main.mcfunction` でクールダウンのカウントダウンとアイテム返却を処理
4. **リスポーン対応**: 死亡時にアイテムが消えないよう、適切な処理が必要（参考：`give_*_items.mcfunction`）
