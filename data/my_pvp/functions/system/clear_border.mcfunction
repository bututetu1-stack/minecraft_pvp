## 直接クリア用: `/function my_pvp:system/clear_border` を実行すると、実行者位置をワールドスポーンに戻し、ボーダーを解除する
execute as @s run worldborder set 59000000
execute as @s at @s run setworldspawn ~ ~ ~
execute as @s run kill @e[tag=border_center]
execute as @s run scoreboard players set #BORDER_RADIUS border_radius 0
gamerule spawnRadius 0
