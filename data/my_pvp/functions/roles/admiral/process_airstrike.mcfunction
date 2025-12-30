# (前半のタイマー処理などはそのまま)
scoreboard players remove @s timer 1
execute if score @s timer matches 1.. run return 0

# --- 攻撃主(飼い主)の特定 ---
# airstrike_center(自分)のIDを取得
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# --- 爆撃実行 ---
summon area_effect_cloud ~ ~ ~ {Tags:["adm_bomb"],Duration:5}
spreadplayers ~ ~ 0 20 false @e[tag=adm_bomb]

# 演出
execute at @e[tag=adm_bomb] run particle minecraft:explosion_emitter ~ ~ ~ 1 0 0 0 1
execute at @e[tag=adm_bomb] run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 3 1

# --- ダメージ処理 (修正) ---
# by @e[tag=adm_bomb] ではなく by @p[tag=attacker_temp] に変更

execute at @e[tag=adm_bomb] if entity @p[tag=attacker_temp] as @a[distance=..5] run damage @s 8 minecraft:explosion by @p[tag=attacker_temp,limit=1]

# 飼い主不在時の予備
execute at @e[tag=adm_bomb] unless entity @p[tag=attacker_temp] as @a[distance=..5] run damage @s 8 minecraft:explosion

# 一時マーカー削除
kill @e[tag=adm_bomb]
tag @a remove attacker_temp

# --- 次のサイクルの準備 ---
scoreboard players remove @s ammo 1
scoreboard players set @s timer 5

# 終了判定
execute unless score @s ammo matches 1.. run kill @e[tag=adm_plane]
execute unless score @s ammo matches 1.. run kill @s