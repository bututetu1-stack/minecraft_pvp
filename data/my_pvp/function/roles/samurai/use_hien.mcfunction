# 飛燕発動 (上昇しながら斬る)
# CTチェック
execute if score @s cd_sam_hien matches 1.. run return 0

# CT設定 (12秒)
scoreboard players set @s cd_sam_hien 240

# 上昇 (Levitation Lv4 で短時間)
effect give @s minecraft:levitation 1 9 true
effect give @s minecraft:resistance 2 0 true

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 周囲(半径3.5)に斬撃ダメージ (6)
execute at @s as @a[distance=..3.5,gamemode=!spectator] unless score @s player_id = #TEMP player_id run damage @s 6 minecraft:magic by @p[tag=samurai,distance=..4,limit=1]

# 演出
particle minecraft:sweep_attack ~ ~1 ~ 1 0.3 1 0 8
particle minecraft:cloud ~ ~ ~ 0.3 0.1 0.3 0.3 15
playsound minecraft:entity.player.attack.sweep master @a ~ ~ ~ 1.5 1.5
playsound minecraft:entity.firework_rocket.launch master @a ~ ~ ~ 1 1.8

tellraw @s [{"text":"[飛燕] ","color":"light_purple","bold":true},{"text":"舞う斬撃！","color":"yellow"}]
