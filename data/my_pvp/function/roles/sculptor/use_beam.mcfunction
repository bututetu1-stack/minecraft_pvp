# 石化光線発動
# @s = sculptor player

# CTセット (10秒 = 200tick)
scoreboard players set @s cd_sculptor_beam 200

# 自分のIDをTEMPに保存 (raycast中の自爆防止)
scoreboard players operation #TEMP player_id = @s player_id

# 命中フラグ初期化
scoreboard players set #BEAM_HIT temp 0

# 発射音 + 発射演出
playsound minecraft:entity.evoker.cast_spell master @a ~ ~ ~ 1.2 0.7
playsound minecraft:block.amethyst_block.chime master @a ~ ~ ~ 1.5 0.6
particle minecraft:flash ~ ~1.5 ~ 0 0 0 0 1 force
particle minecraft:dust{color:[0.5,0.4,0.7],scale:1.5} ~ ~1.5 ~ 0.4 0.3 0.4 0 15 force

# レイキャスト発射 (距離12m = 0.5m * 24 steps)
scoreboard players set #beam_dist temp 24
execute anchored eyes positioned ^ ^ ^ run function my_pvp:roles/sculptor/beam_raycast

# 命中時の追加サウンド
execute if score #BEAM_HIT temp matches 1 run playsound minecraft:block.stone.break master @a ~ ~ ~ 1.5 0.6
execute if score #BEAM_HIT temp matches 1 run playsound minecraft:entity.iron_golem.repair master @a ~ ~ ~ 1 0.5
execute if score #BEAM_HIT temp matches 1 run tellraw @s [{"text":"[石化光線] ","color":"blue","bold":true},{"text":"命中！","color":"yellow"}]
execute if score #BEAM_HIT temp matches 0 run tellraw @s [{"text":"[石化光線] ","color":"blue","bold":true},{"text":"発射 (命中なし)","color":"gray"}]
