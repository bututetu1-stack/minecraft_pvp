# Advancementの解除 (my_pvp:roles/stalker_attack の報酬として実行される / @s = ストーカー)
advancement revoke @s only my_pvp:roles/stalker_attack

# ターゲット判定 Logic
# Advancementトリガーの弱点: "誰を" 攻撃したか @s (attacker) から直接特定するセレクタがない
# -> 直前に被弾した (HurtTime:10) 一番近いプレイヤーを被害者とみなす

# 直近で攻撃されたエンティティを探す (距離制限など)
tag @a remove victim_candidate
execute at @s as @a[distance=..6,tag=!stalker,nbt={HurtTime:10s},limit=1,sort=nearest] run tag @s add victim_candidate
execute unless entity @a[tag=victim_candidate] run return 0

# ターゲットかどうか判定
tag @s remove hitting_target
scoreboard players operation #TEMP player_id = @s target_id
execute if score @a[tag=victim_candidate,limit=1] player_id = #TEMP player_id run tag @s add hitting_target

# 遅延処理の実装 (被弾直後の無敵時間を避けるため 12tick 後にダメージ)
# 実際のダメージは tick_attack_delay -> execute_delayed_attack で与える

# ターゲット (Critical): 10ダメージ
execute if entity @s[tag=hitting_target] as @a[tag=victim_candidate,limit=1] run tag @s add sk_critical
execute if entity @s[tag=hitting_target] at @a[tag=victim_candidate,limit=1] run playsound minecraft:entity.player.attack.crit master @s ~ ~ ~ 1 0.8
execute if entity @s[tag=hitting_target] at @a[tag=victim_candidate,limit=1] run particle minecraft:crit ~ ~1.5 ~ 0.5 0.5 0.5 0.1 20

# 非ターゲット (Normal): 4ダメージ
execute unless entity @s[tag=hitting_target] as @a[tag=victim_candidate,limit=1] run tag @s remove sk_critical
execute unless entity @s[tag=hitting_target] at @s run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5

execute as @a[tag=victim_candidate,limit=1] run tag @s add sk_attack_target
execute as @a[tag=victim_candidate,limit=1] run scoreboard players set @s sk_attack_timer 12

tag @a remove victim_candidate
