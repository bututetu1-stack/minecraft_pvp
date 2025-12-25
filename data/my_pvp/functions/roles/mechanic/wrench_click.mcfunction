# インタラクション情報の削除
data remove entity @s interaction

# ID取得
scoreboard players operation #TEMP player_id = @s player_id

# --- 修理 (Repair) ---
# 近くの持ち主(Mechanic)が実行したとみなす
tag @a remove owner_temp
execute as @a[tag=mechanic,distance=..6] if score @s player_id = #TEMP player_id run tag @s add owner_temp

# 修理実行
execute if entity @p[tag=owner_temp] run function my_pvp:roles/mechanic/repair