# インタラクション情報の削除
data remove entity @s interaction

# ID取得
scoreboard players operation #TEMP player_id = @s player_id

# --- 修理 (Repair) ---
# 近くの持ち主(Mechanic)が実行したとみなす
tag @a remove owner_temp

# 【修正】レンチを持っている場合のみ owner_temp にする
# nbt={SelectedItem:{tag:{is_wrench:1b}}} を追加しました
execute as @a[tag=mechanic,distance=..6,nbt={SelectedItem:{components:{"minecraft:custom_data":{is_wrench:1b}}}}] if score @s player_id = #TEMP player_id run tag @s add owner_temp

# 修理実行
execute if entity @p[tag=owner_temp] run function my_pvp:roles/mechanic/repair