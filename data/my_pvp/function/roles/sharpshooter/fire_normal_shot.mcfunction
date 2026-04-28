# 通常弾発射 (@s = sharpshooter, at @s)

# 自分のIDを TEMP に保存
scoreboard players operation #TEMP player_id = @s player_id
# 命中フラグ初期化
scoreboard players set #SHOT_HIT temp 0

# 発射音 (ハンドガン: 鋭いパァン!)
playsound minecraft:entity.firework_rocket.blast master @a[distance=..40] ~ ~ ~ 1.2 2.0
playsound minecraft:block.dispenser.dispense master @a[distance=..20] ~ ~ ~ 1.5 0.8
playsound minecraft:entity.zombie_villager.cure master @a[distance=..15] ~ ~ ~ 0.5 2.0
# マズルフラッシュ
particle minecraft:flash ~ ~1.5 ~ 0 0 0 0 1 force
particle minecraft:smoke ~ ~1.5 ~ 0.1 0.1 0.1 0.02 4 force

# レイキャスト発射 (距離20m = 0.5m * 40 steps)
scoreboard players set #shot_dist temp 40
execute anchored eyes positioned ^ ^ ^ run function my_pvp:roles/sharpshooter/normal_raycast

# 命中時のメッセージ
execute if score #SHOT_HIT temp matches 1 run tellraw @s [{"text":"[通常弾] ","color":"aqua"},{"text":"命中","color":"yellow"}]
