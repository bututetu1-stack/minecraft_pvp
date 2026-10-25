# 賞金首キル判定
# @s = 死亡した賞金首 (respawn が deaths を 0 に戻す前に game_logic から呼ばれる)

# キルしたプレイヤーを特定
# 1) 直前に攻撃してきたプレイヤー (通常のキル)
tag @a remove bounty_killer
execute on attacker if entity @s[type=player] run tag @s add bounty_killer
# 2) いなければ、彫刻の効果による死亡 (last_attacker_id)
scoreboard players operation #BOUNTY_KILLER temp = @s last_attacker_id
execute unless entity @a[tag=bounty_killer] if score #BOUNTY_KILLER temp matches 1.. as @a if score @s player_id = #BOUNTY_KILLER temp run tag @s add bounty_killer
# 自滅は対象外
tag @s remove bounty_killer

# キラーに50ポイント付与 (bonus_pointsを使用)
execute as @a[tag=bounty_killer] run scoreboard players add @s bonus_points 50
execute as @a[tag=bounty_killer] run tellraw @s [{"text":"[BOUNTY] ","color":"gold"},{"text":"+50 ポイント！","color":"yellow","bold":true}]
execute as @a[tag=bounty_killer] at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1 0.5
tag @a remove bounty_killer

# 賞金首タグを削除
tag @s remove bounty_target

# 全体告知
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"賞金首が倒された！","color":"red"}]
