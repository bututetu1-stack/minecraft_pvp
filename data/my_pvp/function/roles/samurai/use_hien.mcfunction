# 飛燕発動 (跳び上がると同時に周囲を斬る)
# CTチェック
execute if score @s cd_sam_hien matches 1.. run return 0

# CT設定 (12秒)
scoreboard players set @s cd_sam_hien 240

# 上昇 (ピストン射出/リープフェザー基準: amplifier 15)
effect give @s minecraft:levitation 1 15 true
effect give @s minecraft:resistance 2 0 true

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 周囲(半径3.5)にダメージ強化: 6 → 8
tag @a remove sam_hien_hit
execute at @s as @a[distance=..3.5,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add sam_hien_hit
execute as @a[tag=sam_hien_hit] run damage @s 8 minecraft:magic by @p[tag=samurai,distance=..4,limit=1]

# --- 演出 (大幅強化) ---
# 発動瞬間のフラッシュ
particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force

# 周囲斬撃 (半径3.5): 大量パーティクル
particle minecraft:sweep_attack ~ ~1 ~ 1.5 0.5 1.5 0 16 force
particle minecraft:enchanted_hit ~ ~1 ~ 1.2 0.5 1.2 0.1 25 force

# 上昇軌跡: 鈍色ダスト + 風切り雲
particle minecraft:dust{color:[0.7,0.8,0.9],scale:1.0} ~ ~ ~ 0.4 0.5 0.4 0 30 force
particle minecraft:cloud ~ ~ ~ 0.5 0.2 0.5 0.2 25 force
particle minecraft:end_rod ~ ~0.5 ~ 0.3 0.3 0.3 0.05 12 force

# 命中エンティティ位置に追加演出
execute as @a[tag=sam_hien_hit] at @s run particle minecraft:dust{color:[1.0,0.0,0.0],scale:1.3} ~ ~1 ~ 0.5 0.5 0.5 0 25 force
execute as @a[tag=sam_hien_hit] at @s run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force

# 効果音層: 斬撃 + 風 + ロケット + 鳥の鳴き声 (飛燕)
playsound minecraft:entity.player.attack.sweep master @a ~ ~ ~ 2 1.5
playsound minecraft:entity.firework_rocket.launch master @a ~ ~ ~ 1.5 1.6
playsound minecraft:entity.parrot.fly master @a ~ ~ ~ 1.5 1.4
playsound minecraft:item.trident.riptide_3 master @a ~ ~ ~ 1.2 1.5

# 命中音
execute if entity @a[tag=sam_hien_hit] at @s run playsound minecraft:item.trident.hit master @a ~ ~ ~ 1.5 1.4
execute if entity @a[tag=sam_hien_hit] at @s run playsound minecraft:entity.player.attack.crit master @a ~ ~ ~ 1.5 1.5

# チャット通知
tellraw @s [{"text":"[飛燕] ","color":"dark_blue","bold":true},{"text":"舞う斬撃！","color":"yellow"}]

# 後処理
tag @a remove sam_hien_hit
