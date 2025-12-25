# 所有者がいる場合のダメージループ処理
execute as @a[tag=stepping_enemy] run damage @s 8 minecraft:explosion by @p[tag=owner_temp]
execute as @a[distance=2.01..5] run damage @s 4 minecraft:explosion by @p[tag=owner_temp]