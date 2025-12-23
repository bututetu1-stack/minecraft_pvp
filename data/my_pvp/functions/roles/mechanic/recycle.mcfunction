# スクラップを返却
scoreboard players add @p scrap 2

# 演出：煙と解体音
particle minecraft:cloud ~ ~0.5 ~ 0.3 0.3 0.3 0.05 10
playsound minecraft:block.iron_door.close ambient @p ~ ~ ~ 0.5 1.5

# ガジェット本体(@s)を消去
kill @s

# 【追加】近くのHitboxも消去
kill @e[tag=gadget_hitbox,distance=..0.5,limit=1]