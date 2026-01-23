# ブラックジャック (21ちょうど)
# @s = player

tellraw @s {"text":"[BJ] BLACKJACK!! (完勝)","color":"light_purple","bold":true}

# 効果: HP全回復 & 耐性II (20秒) & 20コイン返還
effect give @s minecraft:instant_health 1 255 true
effect give @s minecraft:resistance 20 1 true
scoreboard players add @s coins 20

tellraw @s {"text":"[BJ] HP全回復 & コイン+20","color":"yellow"}
