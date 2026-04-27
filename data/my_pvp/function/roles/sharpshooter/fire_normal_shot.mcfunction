# 通常弾発射 (@s = sharpshooter, at @s)

# 自分のIDを TEMP に保存
scoreboard players operation #TEMP player_id = @s player_id
# 命中フラグ初期化
scoreboard players set #SHOT_HIT temp 0

# 発射音 + 発射演出
playsound minecraft:entity.arrow.shoot master @a[distance=..30] ~ ~ ~ 0.7 1.5
playsound minecraft:block.amethyst_block.chime master @a[distance=..15] ~ ~ ~ 0.5 1.6
particle minecraft:dust{color:[0.4,0.7,1.0],scale:0.8} ~ ~1.5 ~ 0.1 0.1 0.1 0 5 force

# レイキャスト発射 (距離20m = 0.5m * 40 steps)
scoreboard players set #shot_dist temp 40
execute anchored eyes positioned ^ ^ ^ run function my_pvp:roles/sharpshooter/normal_raycast

# 命中時のメッセージ
execute if score #SHOT_HIT temp matches 1 run tellraw @s [{"text":"[通常弾] ","color":"aqua"},{"text":"命中","color":"yellow"}]
