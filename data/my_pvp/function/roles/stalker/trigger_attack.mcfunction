# Advancementの解除
advancement revoke @s only my_pvp:roles/stalker/trigger_attack

# ターゲット判定 Logic
# last_damage_dealtは別途管理不要になるが、ターゲット判定のために victim タグ付けなどが必要
# Advancementトリガーの弱点: "誰を" 攻撃したか @s (attacker) から直接特定するセレクタがない
# -> minecraft:player_hurt_entity の場合は、実行元はプレイヤー(Attacker)

# 直近で攻撃されたエンティティを探す (距離制限など)
tag @a remove victim_candidate
execute at @s as @a[distance=..6,nbt={HurtTime:10s},limit=1,sort=nearest] run tag @s add victim_candidate

# ターゲットかどうか判定
tag @s remove hitting_target
scoreboard players operation #TEMP player_id = @s target_id
execute as @a[tag=victim_candidate] if score @s player_id = #TEMP player_id run tag @p[tag=stalker,distance=..6] add hitting_target

# マクロ分岐 -> 力技 & ターゲット修正 (Victimにダメージを与える)
# 遅延処理の実装 (Thornsなどの無敵時間回避)

# ターゲット (Critical): 10ダメージ
execute if entity @s[tag=hitting_target] as @a[tag=victim_candidate,limit=1] run tag @s add sk_critical
execute if entity @s[tag=hitting_target] as @a[tag=victim_candidate,limit=1] run tag @s add sk_attack_target
execute if entity @s[tag=hitting_target] as @a[tag=victim_candidate,limit=1] run scoreboard players set @s sk_attack_timer 12

# 非ターゲット (Normal): 4ダメージ
execute unless entity @s[tag=hitting_target] as @a[tag=victim_candidate,limit=1] run tag @s remove sk_critical
execute unless entity @s[tag=hitting_target] as @a[tag=victim_candidate,limit=1] run tag @s add sk_attack_target
execute unless entity @s[tag=hitting_target] as @a[tag=victim_candidate,limit=1] run scoreboard players set @s sk_attack_timer 12
