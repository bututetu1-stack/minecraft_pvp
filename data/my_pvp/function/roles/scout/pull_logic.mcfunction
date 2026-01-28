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

# --- 接触ダメージ処理 ---
# 自分に一時的なタグを付与
tag @s add scout_attacker_now

# 周囲2m以内の敵を特定（自分自身を除外）
tag @a remove scout_contact_victim
execute as @a[distance=..2.0,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add scout_contact_victim

# 6ダメージ（ハート3個分）を与える
# 【修正】攻撃元を @p[tag=scout_attacker_now] にすることで確実に自分を指定
execute as @a[tag=scout_contact_victim] run damage @s 4 minecraft:player_attack by @p[tag=scout_attacker_now,limit=1]

# ヒット演出
execute if entity @a[tag=scout_contact_victim] run particle minecraft:crit ~ ~1 ~ 0.3 0.3 0.3 0.1 5
execute if entity @a[tag=scout_contact_victim] run playsound minecraft:entity.player.attack.sweep master @a ~ ~ ~ 0.5 1.5

# タグの掃除
tag @s remove scout_attacker_now

# 風切り音 (5tickに1回)
scoreboard players add @s sound_ticker 1
execute if score @s sound_ticker matches 5.. run playsound minecraft:item.elytra.flying master @s ~ ~ ~ 0.3 2.0
execute if score @s sound_ticker matches 5.. run scoreboard players set @s sound_ticker 0

# --- 5. 到着判定 ---
# アンカーに十分近づいたら終了
execute if entity @e[tag=my_anchor,distance=..2] run function my_pvp:roles/scout/stop_grapple