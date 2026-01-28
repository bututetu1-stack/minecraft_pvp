# 夜戦: 砲撃生成
# 実行位置: ターゲットプレイヤー周辺

# ランダムオフセット
# スコアボード計算は不要 (spreadplayersを使うため)

# オフセット適用してマーカー設置
execute positioned ~ ~ ~ run summon marker ~ ~ ~ {Tags:["pos_marker"]}
execute as @e[tag=pos_marker] run spreadplayers ~ ~ 0 10 false @s
execute at @e[tag=pos_marker] run summon marker ~ ~ ~ {Tags:["artillery_marker","type_kongo","night_artillery"]}
kill @e[tag=pos_marker]

# マーカー設定
execute as @e[tag=night_artillery] run scoreboard players set @s temp 60
execute as @e[tag=night_artillery] run scoreboard players set @s player_id 0


# 警告音
playsound minecraft:entity.lightning_bolt.impact master @a ~ ~ ~ 1 0.5
