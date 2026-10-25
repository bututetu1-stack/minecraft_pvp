# 賞金首キル判定
# @s = 死亡した賞金首

# キルしたプレイヤーを特定 (last_attacker_id)
scoreboard players operation #BOUNTY_KILLER temp = @s last_attacker_id

# キラーに50ポイント付与 (bonus_pointsを使用)
execute as @a if score @s player_id = #BOUNTY_KILLER temp run scoreboard players add @s bonus_points 50
execute as @a if score @s player_id = #BOUNTY_KILLER temp run tellraw @s [{"text":"[BOUNTY] ","color":"gold"},{"text":"+50 ポイント！","color":"yellow","bold":true}]
execute as @a if score @s player_id = #BOUNTY_KILLER temp run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1 0.5

# 賞金首タグを削除
tag @s remove bounty_target

# 全体告知
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"賞金首が倒された！","color":"red"}]
