# --- 1. 攻撃者の完全特定 (UUID照合) ---
# attack.player[...] からUUIDを取得
execute store result score #TARGET_UUID_0 temp run data get entity @s attack.player[0]
execute store result score #TARGET_UUID_1 temp run data get entity @s attack.player[1]
execute store result score #TARGET_UUID_2 temp run data get entity @s attack.player[2]
execute store result score #TARGET_UUID_3 temp run data get entity @s attack.player[3]

# 攻撃データは抽出したので削除（連打防止）
data remove entity @s attack

# 全プレイヤーを検索し、上記IDと一致する人にタグ(current_attacker)をつける
tag @a remove current_attacker
execute as @a run function my_pvp:roles/mechanic/check_uuid


# --- 2. 解体判定 (タレット & レンチ) ---
# 条件: 「タレットの当たり判定」かつ「特定された攻撃者がレンチを持っている」
execute if entity @s[tag=sentry_hitbox] if entity @a[tag=current_attacker,limit=1,nbt={SelectedItem:{tag:{is_wrench:1b}}}] run function my_pvp:roles/mechanic/recycle

# 解体を行った場合はここで終了
execute if entity @s[tag=sentry_hitbox] if entity @a[tag=current_attacker,limit=1,nbt={SelectedItem:{tag:{is_wrench:1b}}}] run return 1


# --- 3. 通常ダメージ処理 ---
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

# --- 修正: 削除順序の変更 ---
# 【重要】brokenが存在する場合のみID取得と削除を行うように変更
# これがないと、壊れていないのに直前のID(#TEMP)を使って自分を消してしまいます
execute if entity @e[tag=broken] run scoreboard players operation #TEMP player_id = @e[tag=broken,limit=1] player_id
execute if entity @e[tag=broken] as @e[tag=gadget_hitbox] if score @s player_id = #TEMP player_id run kill @s

# その後にVisualを消す
kill @e[tag=broken]

# 念の為の自己消去 (Hitbox視点: Visualが見つからなければ消える)
execute unless entity @e[tag=gadget_visual,distance=..2,limit=1] run kill @s