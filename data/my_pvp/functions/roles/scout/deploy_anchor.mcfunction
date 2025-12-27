# 1. アンカー設置
summon marker ~ ~ ~ {Tags:["wire_anchor"]}

# 2. ID引き継ぎ
scoreboard players operation #TEMP player_id = @s player_id
execute as @e[tag=wire_anchor,limit=1,sort=nearest] run scoreboard players operation @s player_id = #TEMP player_id

# 3. プレイヤーに移動フラグを立てる
execute as @a[tag=scout] if score @s player_id = #TEMP player_id run tag @s add is_grappling

# 4. 音と演出
# 着弾音
playsound minecraft:item.crossbow.hit master @a ~ ~ ~ 1 2
# 【追加】ワイヤー移動音 (1回だけ再生)
playsound minecraft:item.elytra.flying master @a ~ ~ ~ 1 2

particle minecraft:crit ~ ~ ~ 0.5 0.5 0.5 0.1 20

# 5. 矢を消す
kill @s