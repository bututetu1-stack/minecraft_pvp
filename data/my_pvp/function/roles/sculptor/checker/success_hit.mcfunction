# ヒット成功 - テーマに応じた効果を付与
# @s = 実行位置にいる, target_hitbox = ヒットした彫刻

# プレイヤーを特定
tag @a[tag=current_checker,limit=1] add sculpture_victim

# キル判定用記録
scoreboard players operation #TEMP_OWNER temp = @e[tag=target_hitbox,limit=1] player_id
execute as @a[tag=sculpture_victim] run scoreboard players operation @s last_attacker_id = #TEMP_OWNER temp
execute as @a[tag=sculpture_victim] run scoreboard players set @s sculptor_hit_timer 200

# テーマ別効果付与
execute if entity @e[tag=target_hitbox,tag=sculpture_nausea,limit=1] as @a[tag=sculpture_victim] run effect give @s minecraft:nausea 5 0 true
execute if entity @e[tag=target_hitbox,tag=sculpture_poison,limit=1] unless entity @a[tag=sculpture_victim,nbt={active_effects:[{id:"minecraft:poison"}]}] as @a[tag=sculpture_victim] run effect give @s minecraft:poison 3 0 true
execute if entity @e[tag=target_hitbox,tag=sculpture_slow,limit=1] as @a[tag=sculpture_victim] run effect give @s minecraft:slowness 3 1 true
execute if entity @e[tag=target_hitbox,tag=sculpture_blind,limit=1] as @a[tag=sculpture_victim] run effect give @s minecraft:blindness 3 0 true
execute if entity @e[tag=target_hitbox,tag=sculpture_glow,limit=1] as @a[tag=sculpture_victim] run effect give @s minecraft:glowing 5 0 true
execute if entity @e[tag=target_hitbox,tag=sculpture_darkness,limit=1] as @a[tag=sculpture_victim] run effect give @s minecraft:darkness 3 0 true
execute if entity @e[tag=target_hitbox,tag=sculpture_fatigue,limit=1] as @a[tag=sculpture_victim] run effect give @s minecraft:mining_fatigue 3 2 true

# タグ削除
tag @a remove sculpture_victim
