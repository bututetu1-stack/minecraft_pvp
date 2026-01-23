# エフェクト適用
# @s = sculpture_hitbox
# 実行者(@a[tag=current_raycaster])に対して処理を行う

# --- 0. 自分自身の彫刻なら無視 ---
scoreboard players operation #TEMP_OWNER temp = @s player_id
execute as @a[tag=current_raycaster] if score @s player_id = #TEMP_OWNER temp run return 0

# --- 1. 視線判定の可視化 & キル判定用記録 ---
# --- 1. 視線判定の可視化 & キル判定用記録 ---
# アクションバーはCT表示に使われているため、tellrawやsubtitleを使用
# ここではtellraw (ログ流れるが確実) か title subtitle (邪魔かも)
# ユーザー要望は tell なので tellraw で。
# 毎tick出るとログが消えるので、間引くか、あるいはアクションバーの優先度を変えるか…
# とりあえず tellraw で出すが、毎tickだとスパムになる。
# しかし「警告して」と言われたので毎tick出す。
execute as @a[tag=current_raycaster] run tellraw @s {"text":"[!] 彫刻を直視しています","color":"red"}

# ID記録 (キル判定用)
scoreboard players operation #TEMP_OWNER temp = @s player_id
execute as @a[tag=current_raycaster] run scoreboard players operation @s last_attacker_id = #TEMP_OWNER temp
execute as @a[tag=current_raycaster] run scoreboard players set @s sculptor_hit_timer 200

# --- 2. 効果付与 ---
# 毒: 既に毒(Id:19)を持っている場合はスキップ (更新によるダメージ無効化防止)
execute if entity @s[tag=sculpture_poison] unless entity @a[tag=current_raycaster,nbt={ActiveEffects:[{Id:19}]}] as @a[tag=current_raycaster] run effect give @s minecraft:poison 3 0 true

# その他の効果
execute if entity @s[tag=sculpture_nausea] as @a[tag=current_raycaster] run effect give @s minecraft:nausea 5 0 true
execute if entity @s[tag=sculpture_slow] as @a[tag=current_raycaster] run effect give @s minecraft:slowness 3 1 true
execute if entity @s[tag=sculpture_blind] as @a[tag=current_raycaster] run effect give @s minecraft:blindness 3 0 true
execute if entity @s[tag=sculpture_glow] as @a[tag=current_raycaster] run effect give @s minecraft:glowing 5 0 true
execute if entity @s[tag=sculpture_darkness] as @a[tag=current_raycaster] run effect give @s minecraft:darkness 3 0 true
execute if entity @s[tag=sculpture_fatigue] as @a[tag=current_raycaster] run effect give @s minecraft:mining_fatigue 3 2 true
