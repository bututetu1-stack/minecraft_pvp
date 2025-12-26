# 1. 攻撃者の特定 (UUID照合)
# interactionエンティティの attack.player からUUIDを取得
execute store result score #TARGET_UUID_0 temp run data get entity @s attack.player[0]
execute store result score #TARGET_UUID_1 temp run data get entity @s attack.player[1]
execute store result score #TARGET_UUID_2 temp run data get entity @s attack.player[2]
execute store result score #TARGET_UUID_3 temp run data get entity @s attack.player[3]

# 攻撃データを削除（連打防止）
data remove entity @s interaction

# 全プレイヤーから該当者を探す (Mechanicのcheck_uuidを再利用)
tag @a remove current_attacker
execute as @a run function my_pvp:roles/mechanic/check_uuid

# 2. 所有者(自分)チェック
scoreboard players operation #TEMP player_id = @s player_id
# 攻撃者が「この身代わりの持ち主」である場合、処理をキャンセル(return 0)
execute as @a[tag=current_attacker] if score @s player_id = #TEMP player_id run return 0


# --- 以下、他プレイヤーによる破壊処理 ---

# 3. 破壊演出
particle minecraft:poof ~ ~1 ~ 0.3 0.3 0.3 0.1 20
playsound minecraft:entity.generic.extinguish_fire ambient @a ~ ~ ~ 1 1

# 4. 本体（見た目）を道連れにする
execute at @s as @e[tag=shadow_visual,distance=..0.5,limit=1] if score @s player_id = #TEMP player_id run kill @s

# 5. 自分（当たり判定）を消す
kill @s