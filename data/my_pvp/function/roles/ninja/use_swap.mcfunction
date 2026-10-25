# 1. CTチェック
execute if score @s cd_ninja_swap matches 1.. run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2
execute if score @s cd_ninja_swap matches 1.. run return 0

# 2. 入れ替え対象の特定
# まずターゲットタグを掃除
tag @e remove target_shadow

# 手に持っているアイテムのタグ(swap_1, swap_2, swap_3)を見て、対応する身代わり(shadow_slot_X)を探す
execute if entity @s[nbt={SelectedItem:{components:{"minecraft:custom_data":{Tags:["swap_1"]}}}}] as @e[tag=shadow_visual,tag=shadow_slot_1] if score @s player_id = @p player_id run tag @s add target_shadow
execute if entity @s[nbt={SelectedItem:{components:{"minecraft:custom_data":{Tags:["swap_2"]}}}}] as @e[tag=shadow_visual,tag=shadow_slot_2] if score @s player_id = @p player_id run tag @s add target_shadow
execute if entity @s[nbt={SelectedItem:{components:{"minecraft:custom_data":{Tags:["swap_3"]}}}}] as @e[tag=shadow_visual,tag=shadow_slot_3] if score @s player_id = @p player_id run tag @s add target_shadow

# 対象が見つからなければエラーを出して終了
execute unless entity @e[tag=target_shadow] run tellraw @s {"text":"⚠ その番号の身代わりはありません","color":"red"}
execute unless entity @e[tag=target_shadow] run return 0

# --- 3. 入れ替え実行 (位置＋向きの完全交換) ---
# CT設定 (10秒)
scoreboard players set @s cd_ninja_swap 200

# ゴミ掃除
kill @e[tag=pos_temp]

# A. 場所と向きの保存
# A-1. プレイヤー(@s)の場所にマーカーAを作成し、向きをコピー
summon marker ~ ~ ~ {Tags:["pos_temp","pos_player"]}
data modify entity @e[tag=pos_player,limit=1,distance=..0.1] Rotation set from entity @s Rotation

# A-2. 身代わり(@e[target_shadow])の場所にマーカーBを作成し、向きをコピー
execute at @e[tag=target_shadow,limit=1] run summon marker ~ ~ ~ {Tags:["pos_temp","pos_shadow"]}
execute at @e[tag=target_shadow,limit=1] run data modify entity @e[tag=pos_shadow,limit=1,distance=..0.1] Rotation set from entity @e[tag=target_shadow,limit=1] Rotation

# B. 演出
particle minecraft:poof ~ ~1 ~ 0.5 0.5 0.5 0.1 30
playsound minecraft:entity.enderman.teleport master @a ~ ~ ~ 1 1.5
execute at @e[tag=target_shadow,limit=1] run particle minecraft:poof ~ ~1 ~ 0.5 0.5 0.5 0.1 30

# C. テレポート実行
# 忍者 -> マーカーB(身代わりの場所・向き)へ
tp @s @e[tag=pos_shadow,limit=1]

# 身代わり(見た目) -> マーカーA(忍者の場所・向き)へ
execute as @e[tag=target_shadow,limit=1] run tp @s @e[tag=pos_player,limit=1]

# 身代わり(判定) -> 身代わり(見た目)へ集合
# 同じスロット・同じ持ち主の当たり判定だけを動かす (以前は50m以内の任意の1体を動かしており、
# 身代わりが2体以上あると別の当たり判定が動いて、入れ替えた身代わりの判定が元の位置に残っていた)
scoreboard players operation #SWAP_ID temp = @s player_id
execute if entity @e[tag=target_shadow,tag=shadow_slot_1] as @e[tag=shadow_hitbox,tag=shadow_slot_1] if score @s player_id = #SWAP_ID temp run tag @s add target_shadow_hitbox
execute if entity @e[tag=target_shadow,tag=shadow_slot_2] as @e[tag=shadow_hitbox,tag=shadow_slot_2] if score @s player_id = #SWAP_ID temp run tag @s add target_shadow_hitbox
execute if entity @e[tag=target_shadow,tag=shadow_slot_3] as @e[tag=shadow_hitbox,tag=shadow_slot_3] if score @s player_id = #SWAP_ID temp run tag @s add target_shadow_hitbox
execute as @e[tag=target_shadow_hitbox] run tp @s @e[tag=target_shadow,limit=1]
tag @e remove target_shadow_hitbox

# D. 後始末
kill @e[tag=pos_temp]
tag @e remove target_shadow