# マーキング弾発動 (@s = sharpshooter, at @s)

# 自分のIDを TEMP に保存
scoreboard players operation #TEMP player_id = @s player_id
# 命中フラグ初期化
scoreboard players set #MARK_HIT temp 0

# 発射音 (信号銃: 軽いパンッ + ピューン)
playsound minecraft:entity.firework_rocket.blast master @a[distance=..40] ~ ~ ~ 0.9 1.7
playsound minecraft:block.dispenser.dispense master @a[distance=..20] ~ ~ ~ 1.2 1.0
playsound minecraft:block.note_block.pling master @a[distance=..20] ~ ~ ~ 1 2.0
# マズルフラッシュ (黄色)
particle minecraft:flash ~ ~1.5 ~ 0 0 0 0 1 force
particle minecraft:smoke ~ ~1.5 ~ 0.1 0.1 0.1 0.02 4 force
particle minecraft:dust{color:[1.0,1.0,0.3],scale:1.0} ~ ~1.5 ~ 0.2 0.2 0.2 0 10 force

# レイキャスト発射 (距離25m = 0.5m * 50 steps)
scoreboard players set #mark_dist temp 50
execute anchored eyes positioned ^ ^ ^ run function my_pvp:roles/sharpshooter/mark_raycast

# 命中時のメッセージ
execute if score #MARK_HIT temp matches 1 run tellraw @s [{"text":"[マーキング弾] ","color":"yellow","bold":true},{"text":"標的捕捉","color":"gold"}]
execute if score #MARK_HIT temp matches 0 run tellraw @s [{"text":"[マーキング弾] ","color":"yellow","bold":true},{"text":"発射 (命中なし)","color":"gray"}]
