# 業火符の燃焼 (毎tick) - バニラの燃焼と同じく 1秒ごとに1ダメージ
# @s = 燃えているプレイヤー (at @s)
scoreboard players remove @s inferno_burn 1
particle minecraft:flame ~ ~1 ~ 0.3 0.5 0.3 0.02 3

scoreboard players set #INF_20 temp 20
scoreboard players operation #INF_BURN temp = @s inferno_burn
scoreboard players operation #INF_BURN temp %= #INF_20 temp
execute if score #INF_BURN temp matches 0 run damage @s 1 minecraft:on_fire
