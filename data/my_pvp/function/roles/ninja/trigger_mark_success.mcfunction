# 実行者(@s) = 落ちている黒染料アイテム

# 1. 設置場所の決定
# アイテムの座標にマーカーを出す
summon marker ~ ~ ~ {Tags:["temp_shadow_loc"]}

# 2. 所有者を特定 (向きの同期のため)
# アイテムに記録されたIDを持つ忍者を一時的に特定する
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove current_caster
execute as @a[tag=ninja] if score @s player_id = #TEMP player_id run tag @s add current_caster

# 3. 設置ロジックの呼び出し
# マーカーの位置で実行
execute at @e[tag=temp_shadow_loc,limit=1] as @p[tag=current_caster] run function my_pvp:roles/ninja/place_shadow_logic

# 4. アイテム消去 & 掃除
kill @e[tag=temp_shadow_loc]
# kill @s は削除（親関数 process_mark で消すため）