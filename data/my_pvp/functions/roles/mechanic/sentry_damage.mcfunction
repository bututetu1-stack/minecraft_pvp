# 左クリック情報の削除（連打防止）
data remove entity @s attack

# --- 1. 解体判定 (レンチを持っているか？) ---
# 攻撃者(attacker)が「レンチ」を持っているかチェック
execute on attacker if entity @s[nbt={SelectedItem:{tag:{is_wrench:1b}}}] run function my_pvp:roles/mechanic/recycle
execute on attacker if entity @s[nbt={SelectedItem:{tag:{is_wrench:1b}}}] run return 0

# --- 2. 通常ダメージ処理 (レンチ以外) ---
# ヒット音
playsound minecraft:block.anvil.land ambient @a ~ ~ ~ 0.5 1.5
particle minecraft:crit ~ ~1 ~ 0.3 0.5 0.3 0.1 5

# 本体(Visual)を探してHPを減らす
scoreboard players operation #TEMP player_id = @s player_id
execute at @s as @e[tag=gadget_visual,distance=..1] if score @s player_id = #TEMP player_id run scoreboard players remove @s gadget_hp 1

# 破壊判定 (HP <= 0)
execute as @e[tag=gadget_visual,scores={gadget_hp=..0}] run tag @s add broken
execute at @e[tag=broken] run particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
execute at @e[tag=broken] run playsound minecraft:entity.generic.explode ambient @a ~ ~ ~ 1 1

# 片付け
kill @e[tag=broken]
execute if entity @e[tag=broken] run kill @s