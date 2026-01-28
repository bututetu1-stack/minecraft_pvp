# 実行者: 矢 (@s)
# 前提: arrow_tick.mcfunction でヒットした敵にタグ 'arrow_hit_victim' が付いていること

# 1. 矢の所有者（スカウト）を特定する
tag @a remove current_owner
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=scout] if score @s player_id = #TEMP player_id run tag @s add current_owner

# 4. 効果音と演出
execute at @a[tag=arrow_hit_victim] run playsound minecraft:entity.fishing_bobber.retrieve master @a ~ ~ ~ 1 1
execute at @a[tag=arrow_hit_victim] run particle minecraft:crit ~ ~1 ~ 0.5 0.5 0.5 0.1 30

