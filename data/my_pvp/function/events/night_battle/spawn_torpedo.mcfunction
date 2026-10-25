# 夜戦: 魚雷生成
# 実行位置: ターゲットプレイヤー周辺

# 周囲からランダムな方向を向いてスポーン
summon marker ~ ~ ~ {Tags:["pos_marker"]}
execute as @e[tag=pos_marker] run spreadplayers ~ ~ 15 25 false @s
execute at @e[tag=pos_marker] run summon armor_stand ~ ~1 ~ {Tags:["adm_torpedo","night_torpedo","type_shimakaze","night_new"],Invisible:1b,Marker:1b,NoGravity:1b}
execute as @e[tag=night_new] at @s facing entity @a[tag=night_target,limit=1] feet run tp @s ~ ~ ~ ~ ~
kill @e[tag=pos_marker]

# 設定 (今召喚したものだけ。既存の魚雷まで初期化すると、向きとタイマーが毎回リセットされる)
execute as @e[tag=night_new] run scoreboard players set @s temp 0
execute as @e[tag=night_new] run scoreboard players set @s player_id 0
tag @e[tag=night_new] remove night_new


# 発射音
playsound minecraft:entity.squid.squirt master @a ~ ~ ~ 1 0.5
