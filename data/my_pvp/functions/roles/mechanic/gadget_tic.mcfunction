# --- タレット攻撃 ---
execute at @s as @a[distance=0.1..7] unless score @s player_id = @e[tag=gadget,limit=1,sort=nearest,distance=..1] player_id run function my_pvp:roles/mechanic/sentry_attack
# 被ダメージ(左クリック)処理
execute as @e[tag=sentry_hitbox] if data entity @s interaction.attack run function my_pvp:roles/mechanic/sentry_damage

# --- 地雷処理 ---
execute as @e[tag=mine] at @s as @a[distance=..1.5] unless score @s player_id = @e[tag=mine,limit=1,sort=nearest,distance=..1] player_id run function my_pvp:roles/mechanic/mine_explode

# --- ランチャー処理 ---
execute as @e[tag=launcher] at @s if entity @a[distance=..1.2] run function my_pvp:roles/mechanic/launcher_trigger

# --- 重力スネア ---
execute as @e[tag=snare,scores={gadget_life=1..}] at @s run function my_pvp:roles/mechanic/snare_tick

# --- 【追加】レンチ操作（右クリック）検知 ---
# すべてのガジェットHitboxに対して、右クリックされたかチェック
# 現状、Hitboxを持っているのはタレットだけなので、タレットのみ反応します
execute as @e[tag=gadget_hitbox] if data entity @s interaction run function my_pvp:roles/mechanic/wrench_click