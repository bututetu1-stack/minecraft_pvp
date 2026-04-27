# 強撃弾発動 (@s = sharpshooter, at @s)

# 自分のIDを TEMP に保存
scoreboard players operation #TEMP player_id = @s player_id
# 命中フラグ初期化
scoreboard players set #PIERCE_HIT temp 0

# 発射音 + 演出 (重い大砲音)
playsound minecraft:item.crossbow.shoot master @a ~ ~ ~ 2 0.5
playsound minecraft:entity.firework_rocket.launch master @a ~ ~ ~ 1.5 0.5
playsound minecraft:item.trident.thunder master @a[distance=..30] ~ ~ ~ 1 1.5
particle minecraft:flash ~ ~1.5 ~ 0 0 0 0 1 force
particle minecraft:dust{color:[1.0,0.2,0.2],scale:1.5} ~ ~1.5 ~ 0.3 0.3 0.3 0 25 force

# レイキャスト発射 (距離35m = 0.5m * 70 steps)
scoreboard players set #pierce_dist temp 70
execute anchored eyes positioned ^ ^ ^ run function my_pvp:roles/sharpshooter/pierce_raycast

# 命中時のメッセージ
execute if score #PIERCE_HIT temp matches 1 run tellraw @s [{"text":"[強撃弾] ","color":"red","bold":true},{"text":"命中！","color":"yellow"}]
execute if score #PIERCE_HIT temp matches 0 run tellraw @s [{"text":"[強撃弾] ","color":"red","bold":true},{"text":"発射 (命中なし)","color":"gray"}]
