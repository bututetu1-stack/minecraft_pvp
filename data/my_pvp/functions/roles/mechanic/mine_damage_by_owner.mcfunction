# 爆発地点から実行される前提
# 踏んだ敵全員にダメージ (execute as を使って単一エンティティ問題を回避)
execute as @a[tag=stepping_enemy] run damage @s 8 minecraft:explosion by @p[tag=owner_temp]
execute as @a[distance=2.01..5] run damage @s 4 minecraft:explosion by @p[tag=owner_temp]