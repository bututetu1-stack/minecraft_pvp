# 彫刻破壊処理
# @s = sculpture_hitbox (interaction)
# 攻撃者検出とテーマ別効果発動

# 1. 攻撃を受けたか確認 (attack data が存在するか)
execute unless data entity @s attack run return 0

# 2. 攻撃者を特定
tag @a remove current_attacker
execute on attacker run tag @s add current_attacker

# 攻撃データをクリアして連続検知を防ぐ (残したままだと毎tick HP が減り、1回殴っただけで壊れる)
data remove entity @s attack

# 3. 所有者のIDを取得
scoreboard players operation #TEMP_OWNER temp = @s player_id

# 4. 所有者以外が攻撃した場合のみ処理
execute as @a[tag=current_attacker] if score @s player_id = #TEMP_OWNER temp run tag @s remove current_attacker
execute unless entity @a[tag=current_attacker] run return 0

# 【修正】HP処理
# ダメージ音
playsound minecraft:entity.armor_stand.hit master @a ~ ~ ~ 1 1

# HPを減らす
scoreboard players remove @s sculpture_hp 1

# HPが残っているならここで終了 (破壊しない)
execute if score @s sculpture_hp matches 1.. run tag @a remove current_attacker
execute if score @s sculpture_hp matches 1.. run return 0

# --- 以下、HPが0になった場合の破壊処理 ---

# 5. 近くの彫刻本体を探して削除
# 同じplayer_idを持ち、最も近い彫刻を対象
execute at @s as @e[tag=sculpture,distance=..1,limit=1,sort=nearest] run function my_pvp:roles/sculptor/sculpture_destroy_effect

# 6. 所有者のカウント減少
execute as @a if score @s player_id = #TEMP_OWNER temp run scoreboard players remove @s sculpture_count 1

# 7. hitbox自身を削除
kill @s

# 8. タグ解除
tag @a remove current_attacker
