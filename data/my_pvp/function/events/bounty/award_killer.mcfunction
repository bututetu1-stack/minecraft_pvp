# 賞金首キル報酬 (advancement reward, @s = killer)

# Advancement を取り消し (再使用可能に)
advancement revoke @s only my_pvp:events/bounty_killed

# +50 ポイント (bonus_points 経由で points に加算)
scoreboard players add @s bonus_points 50
tellraw @s [{"text":"[BOUNTY] ","color":"gold","bold":true},{"text":"+50 ポイント！","color":"yellow","bold":true}]
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1 0.5
playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1.5

# 全体告知
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text":" が賞金首を倒した！","color":"red"}]
