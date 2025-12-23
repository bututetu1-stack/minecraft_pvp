# --- タレット ---
execute at @s as @a[distance=0.1..7] unless score @s player_id = @e[tag=gadget,limit=1,sort=nearest,distance=..1] player_id run function my_pvp:roles/mechanic/sentry_attack
execute as @e[tag=sentry_hitbox] if data entity @s interaction.attack run function my_pvp:roles/mechanic/sentry_damage

# --- 地雷 ---
execute as @e[tag=mine] at @s as @a[distance=..1.5] unless score @s player_id = @e[tag=mine,limit=1,sort=nearest,distance=..1] player_id run function my_pvp:roles/mechanic/mine_explode

# --- ランチャー ---
execute as @e[tag=launcher] at @s if entity @a[distance=..1.2] run function my_pvp:roles/mechanic/launcher_trigger

# --- 【追加】重力スネア ---
# gadget_lifeが1以上のスネアのみ実行
execute as @e[tag=snare,scores={gadget_life=1..}] at @s run function my_pvp:roles/mechanic/snare_tick