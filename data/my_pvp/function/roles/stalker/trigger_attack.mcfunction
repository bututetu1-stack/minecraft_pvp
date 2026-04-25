# 【リファクタリング版】 ストーカーの追加ダメージ
# my_pvp:penalty (bypasses_invulnerability) で i-frame を貫通するため、遅延処理は不要。
# Advancement (player_hurt_entity) のリワードとして @s = stalker(攻撃者) で実行されます。

# Advancementの解除 (再利用のため)
advancement revoke @s only my_pvp:roles/stalker/trigger_attack

# 直近で攻撃されたエンティティを探す (HurtTime=10s)
tag @a remove victim_candidate
execute at @s as @a[distance=..6,nbt={HurtTime:10s},limit=1,sort=nearest] run tag @s add victim_candidate

# ターゲットかどうか判定
scoreboard players operation #TEMP player_id = @s target_id

# ターゲット (Critical): +6 追加ダメージ (武器4 + 6 = 10 計5ハート)
execute as @a[tag=victim_candidate] if score @s player_id = #TEMP player_id run damage @s 6 my_pvp:penalty by @p[tag=stalker,limit=1,sort=nearest]
execute as @a[tag=victim_candidate] if score @s player_id = #TEMP player_id at @s run particle minecraft:crit ~ ~1.5 ~ 0.5 0.5 0.5 0.1 20
execute as @a[tag=victim_candidate] if score @s player_id = #TEMP player_id at @s run playsound minecraft:entity.player.attack.crit master @a[distance=..16] ~ ~ ~ 1 0.8

# 非ターゲット: ミス演出のみ
execute as @a[tag=victim_candidate] unless score @s player_id = #TEMP player_id at @s run playsound minecraft:block.note_block.bass master @p[tag=stalker,distance=..6] ~ ~ ~ 1 0.5

# 後始末
tag @a remove victim_candidate
