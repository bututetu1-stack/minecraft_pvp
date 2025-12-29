# 1. アンカー設置 (既存)
summon marker ~ ~ ~ {Tags:["wire_anchor"]}

# 2. ID引き継ぎ (既存)
scoreboard players operation #TEMP player_id = @s player_id
execute as @e[tag=wire_anchor,limit=1,sort=nearest] run scoreboard players operation @s player_id = #TEMP player_id

# 3. プレイヤーに移動フラグを立てる (既存)
execute as @a[tag=scout] if score @s player_id = #TEMP player_id run tag @s add is_grappling

# --- 【追加】 4. 着弾地点の範囲ダメージ ---
# 所有者を特定
tag @a remove current_owner
execute as @a[tag=scout] if score @s player_id = #TEMP player_id run tag @s add current_owner

# 範囲内の敵を特定 (半径3m)
tag @a remove anchor_damage_target
execute as @a[distance=..3,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add anchor_damage_target

# ダメージ実行 (4ダメージ = ハート2個)
execute as @a[tag=anchor_damage_target] run damage @s 4 minecraft:arrow by @p[tag=current_owner,limit=1]

# ヒット演出
execute if entity @a[tag=anchor_damage_target] run particle minecraft:crit ~ ~0.5 ~ 0.5 0.5 0.5 0.1 20
execute if entity @a[tag=anchor_damage_target] run playsound minecraft:entity.player.hurt master @a ~ ~ ~ 1 1

# 5. 音と演出 (既存)
playsound minecraft:item.crossbow.hit master @a ~ ~ ~ 1 2
playsound minecraft:item.elytra.flying master @s ~ ~ ~ 1 2
particle minecraft:crit ~ ~ ~ 0.5 0.5 0.5 0.1 20

# 6. 矢を消す (既存)
kill @s