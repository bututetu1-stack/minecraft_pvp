# 狙撃弾発動 (視線方向にレイキャスト)

# CTセット (14秒 = 280tick)
scoreboard players set @s cd_sharp_snipe 280

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 命中フラグ初期化
scoreboard players set #SNIPE_HIT temp 0

# 発射音 + 演出
playsound minecraft:item.crossbow.shoot master @a ~ ~ ~ 2 0.6
playsound minecraft:entity.firework_rocket.launch master @a ~ ~ ~ 1.2 0.5
particle minecraft:flash ~ ~1.5 ~ 0 0 0 0 1 force
particle minecraft:dust{color:[1.0,0.2,0.2],scale:1.2} ~ ~1.5 ~ 0.3 0.3 0.3 0 15 force

# レイキャスト発射 (距離30m = 0.5m * 60 steps)
scoreboard players set #snipe_dist temp 60
execute anchored eyes positioned ^ ^ ^ run function my_pvp:roles/sharpshooter/snipe_raycast

# 命中時のメッセージ
execute if score #SNIPE_HIT temp matches 1 run tellraw @s [{"text":"[狙撃弾] ","color":"red","bold":true},{"text":"命中！","color":"yellow"}]
execute if score #SNIPE_HIT temp matches 0 run tellraw @s [{"text":"[狙撃弾] ","color":"red","bold":true},{"text":"発射 (命中なし)","color":"gray"}]
