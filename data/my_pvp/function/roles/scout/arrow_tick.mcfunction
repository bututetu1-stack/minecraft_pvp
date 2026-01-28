# 【追加】凍結中は処理を停止
execute if entity @s[tag=is_frozen] run return 0

# --- 1. ダメージ無効化 (既存) ---
data merge entity @s {damage:0.0d}

# --- 【追加】 2. 対プレイヤー ヒット判定 (引き寄せ) ---
# 所有者のIDを取得
scoreboard players operation #TEMP player_id = @s player_id

# 近く(半径2m以内)の敵を検知
tag @a remove arrow_hit_victim
execute as @a[distance=..2.0,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add arrow_hit_victim

# ヒット時の処理
execute if entity @a[tag=arrow_hit_victim] run function my_pvp:roles/scout/arrow_hit_logic

# --- 3. 接地判定 (既存) ---
# プレイヤーに当たらず地面についた場合
execute if entity @s[nbt={inGround:1b}] run function my_pvp:roles/scout/deploy_anchor

# --- 4. 寿命 (既存) ---
scoreboard players add @s gadget_life 1
execute if score @s gadget_life matches 100.. run kill @s