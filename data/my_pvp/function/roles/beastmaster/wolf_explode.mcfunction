# 狼自爆処理 (@s = wolf, at @s)
# 呼び出し元で #TEMP player_id = beastmaster の player_id

# 演出
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1.2 1.2
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1 force
particle minecraft:dust{color:[1.0,0.3,0.3],scale:1.3} ~ ~1 ~ 0.5 0.5 0.5 0 25 force
particle minecraft:large_smoke ~ ~ ~ 0.5 0.3 0.5 0.05 15 force

# オーナー特定 (player_id 一致のbeastmaster)
tag @a remove wolf_owner_temp
execute as @a[tag=beastmaster] if score @s player_id = #TEMP player_id run tag @s add wolf_owner_temp

# 被害者をマーク (半径3, オーナー以外)
tag @a remove wolf_victim
execute at @s as @a[gamemode=!spectator,distance=..3] unless score @s player_id = #TEMP player_id run tag @s add wolf_victim

# ダメージ + 浮き効果 (攻撃主帰属でオーナーを指定)
execute as @a[tag=wolf_victim] run damage @s 5 minecraft:player_explosion by @p[tag=wolf_owner_temp,limit=1]
execute as @a[tag=wolf_victim] run effect give @s minecraft:levitation 1 1 true

# キル判定: HPが 0 以下になったらオーナーに kills を加算 (魔術師パターン)
execute as @a[tag=wolf_victim] store result score #TARGET_HP temp run data get entity @s Health 100
execute as @a[tag=wolf_victim] if score #TARGET_HP temp matches ..0 as @p[tag=wolf_owner_temp,limit=1] run scoreboard players add @s kills 1

# 後始末
tag @a remove wolf_victim
tag @a remove wolf_owner_temp

# 自分(狼) を消滅
kill @s
