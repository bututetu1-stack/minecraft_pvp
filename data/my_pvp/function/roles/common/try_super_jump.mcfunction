# --- 共通スキル: 大ジャンプ (Shift検知) ---

# 1. スコアリセット (検知済みのため、連続検知を防ぐなら工夫が必要だが、簡易的にリセット)
scoreboard players set @s sneak_time 0

# 2. クールダウンチェック
# CD中は何もせず終了 (長押しでのメッセージスパム防止)
execute if score @s cd_super_jump matches 1.. run return 0

# 3. 発動処理
# CDセット (20秒 = 400tick)
scoreboard players set @s cd_super_jump 400

# 効果付与 (浮遊 Lv15)
# 瞬間的に跳ね上がる
effect give @s minecraft:levitation 1 15 true

# 演出
playsound minecraft:entity.blaze.shoot master @a ~ ~ ~ 1 1
particle minecraft:cloud ~ ~ ~ 0.2 0 0.2 0.1 10
# tellraw @s [{"text":"[System] ","color":"gray"},{"text":"大ジャンプ！","color":"aqua"}]
