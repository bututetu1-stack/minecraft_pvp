# 夜戦: 航空支援生成
# 実行位置: ターゲットプレイヤー周辺

# ランダムオフセット
summon marker ~ ~ ~ {Tags:["pos_marker"]}
execute as @e[tag=pos_marker] run spreadplayers ~ ~ 0 15 false @s
execute at @e[tag=pos_marker] run summon marker ~ ~ ~ {Tags:["bomb_marker","type_suisei","night_bomb","adm_bomb","bomb_falling"],CustomName:'{"text":"彗星一二型甲","color":"red","bold":true}'}
kill @e[tag=pos_marker]

# 設定
execute as @e[tag=night_bomb] run scoreboard players set @s temp 40
execute as @e[tag=night_bomb] run scoreboard players set @s player_id 0
# 最初は空中に配置
execute as @e[tag=night_bomb] at @s run tp @s ~ ~20 ~


# 警告音
playsound minecraft:entity.phantom.swoop master @a ~ ~ ~ 1 0.5
