# 1. キャンセル判定 (スニークで解除)
execute if predicate my_pvp:is_sneaking run function my_pvp:roles/scout/stop_grapple
execute if predicate my_pvp:is_sneaking run return 0

# 2. 自分のアンカーを特定
scoreboard players operation #TEMP player_id = @s player_id
tag @e remove my_anchor
execute as @e[tag=wire_anchor] if score @s player_id = #TEMP player_id run tag @s add my_anchor

# アンカーが見つからなければ終了
execute unless entity @e[tag=my_anchor] run tag @s remove is_grappling
execute unless entity @e[tag=my_anchor] run return 0

# --- 3. 衝突判定と移動 ---

# まず「アンカーの方を向いた状態」で処理を行う準備
execute facing entity @e[tag=my_anchor,limit=1] feet positioned as @s run function my_pvp:roles/scout/check_collision

# --- 4. 演出とループ処理 ---
# 浮遊感
effect give @s minecraft:slow_falling 1 0 true
# 雲のパーティクル
particle minecraft:cloud ~ ~0.5 ~ 0 0 0 0.05 1

# 風切り音 (5tickに1回)
scoreboard players add @s sound_ticker 1
execute if score @s sound_ticker matches 5.. run playsound minecraft:item.elytra.flying master @s ~ ~ ~ 0.3 2.0
execute if score @s sound_ticker matches 5.. run scoreboard players set @s sound_ticker 0

# --- 5. 到着判定 ---
# アンカーに十分近づいたら終了
execute if entity @e[tag=my_anchor,distance=..2] run function my_pvp:roles/scout/stop_grapple