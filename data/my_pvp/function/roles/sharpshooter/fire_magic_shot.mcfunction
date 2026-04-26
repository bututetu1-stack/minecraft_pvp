# 魔導弾発射 (@s = sharpshooter, 集中中)

# 自分のIDを TEMP に保存
scoreboard players operation #TEMP player_id = @s player_id
# 命中フラグ初期化
scoreboard players set #SHOT_HIT temp 0

# 発射音 + 発射演出
playsound minecraft:entity.arrow.shoot master @a[distance=..30] ~ ~ ~ 0.6 1.5
playsound minecraft:block.amethyst_block.chime master @a[distance=..15] ~ ~ ~ 0.5 1.6
particle minecraft:enchant ~ ~1.5 ~ 0 0 0 0.5 3 force
particle minecraft:dust{color:[0.4,0.7,1.0],scale:0.8} ~ ~1.5 ~ 0.1 0.1 0.1 0 5 force

# レイキャスト発射 (距離20m = 0.5m * 40 steps)
scoreboard players set #shot_dist temp 40
execute anchored eyes positioned ^ ^ ^ run function my_pvp:roles/sharpshooter/auto_fire_raycast
