# 強撃弾発動 (@s = sharpshooter, at @s)

# 自分のIDを TEMP に保存
scoreboard players operation #TEMP player_id = @s player_id
# 命中フラグ初期化
scoreboard players set #PIERCE_HIT temp 0

# 発射音 (スナイパーライフル: 重いドガァァン + 残響)
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1.2 1.8
playsound minecraft:entity.firework_rocket.large_blast_far master @a ~ ~ ~ 1.5 1.4
playsound minecraft:entity.lightning_bolt.impact master @a[distance=..50] ~ ~ ~ 0.6 1.6
playsound minecraft:block.netherite_block.break master @a[distance=..30] ~ ~ ~ 0.7 0.6
# マズルフラッシュ + 反動煙
particle minecraft:flash ~ ~1.5 ~ 0 0 0 0 2 force
particle minecraft:large_smoke ~ ~1.5 ~ 0.3 0.3 0.3 0.02 8 force
particle minecraft:dust{color:[1.0,0.4,0.2],scale:1.5} ~ ~1.5 ~ 0.4 0.4 0.4 0 20 force

# レイキャスト発射 (距離無制限 = 1000m / ブロック衝突 or 命中まで貫通)
scoreboard players set #pierce_dist temp 2000
execute anchored eyes positioned ^ ^ ^ run function my_pvp:roles/sharpshooter/pierce_raycast

# 命中時のメッセージ + 弾1発回復
execute if score #PIERCE_HIT temp matches 1 run tellraw @s [{"text":"[強撃弾] ","color":"red","bold":true},{"text":"命中！ (+1 Ammo)","color":"yellow"}]
execute if score #PIERCE_HIT temp matches 1 run scoreboard players add @s sharp_ammo 1
execute if score @s sharp_ammo matches 11.. run scoreboard players set @s sharp_ammo 10
execute if score #PIERCE_HIT temp matches 0 run tellraw @s [{"text":"[強撃弾] ","color":"red","bold":true},{"text":"発射 (命中なし)","color":"gray"}]
