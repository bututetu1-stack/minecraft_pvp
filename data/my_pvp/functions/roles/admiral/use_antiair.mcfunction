# CTチェック (300 ticks = 15秒)
execute if score @s cd_adm_aa matches 1.. run tellraw @s {"text":"クールダウン中！","color":"red"}
execute if score @s cd_adm_aa matches 1.. run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2
execute if score @s cd_adm_aa matches 1.. run return 0

# 発動
scoreboard players set @s cd_adm_aa 300
playsound minecraft:item.shield.block master @a ~ ~ ~ 2 0.5
particle minecraft:flash ~ ~1 ~ 0 0 0 1 1

# 効果: 周囲5mの敵と矢を吹き飛ばす
execute as @e[type=!player,distance=..5] run tp @s ~ ~0.5 ~
execute as @a[tag=!admiral,distance=..5] run damage @s 0 minecraft:arrow
# ノックバック（tpで無理やり離す簡易実装）
execute as @a[tag=!admiral,distance=..5] facing entity @s feet run tp @s ^ ^0.5 ^-2

# 矢を消す（対空迎撃）
kill @e[type=arrow,distance=..6]
kill @e[type=spectral_arrow,distance=..6]

# 一瞬だけ無敵（レジスタンス5を1秒）
effect give @s minecraft:resistance 1 5 true
tellraw @s {"text":"対空カットイン発動！","color":"green"}