# 1. 攻撃対象候補の取得
tag @a remove attacked_victim
execute at @s as @a[distance=0.1..4,sort=nearest,limit=1,gamemode=!spectator] run tag @s add attacked_victim

# 2. ID照合
scoreboard players operation #TEMP player_id = @s target_id
execute as @a[tag=attacked_victim] if score @s player_id = #TEMP player_id run tag @s add is_my_target

# 3. ターゲットへの追加ダメージ (遅延予約)
# 武器(4) + 追加(6) = 10 (ハート5個)
execute as @a[tag=is_my_target] run scoreboard players set @s penalty_dmg 6
execute as @a[tag=is_my_target] run scoreboard players set @s penalty_timer 12

# 演出
execute if entity @a[tag=is_my_target] run playsound minecraft:entity.player.attack.crit master @s ~ ~ ~ 1 0.8
execute if entity @a[tag=is_my_target] at @a[tag=is_my_target] run particle minecraft:crit ~ ~1.5 ~ 0.5 0.5 0.5 0.1 20

# 4. ミス攻撃演出
execute if entity @a[tag=attacked_victim,tag=!is_my_target] run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5

# 5. タグ掃除
tag @a remove attacked_victim
tag @a remove is_my_target