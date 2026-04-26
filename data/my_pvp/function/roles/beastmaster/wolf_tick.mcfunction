# 狼マーカー 毎tick処理 (@s = wolf armor_stand, at @s)

# 1. 寿命減算 → 0で消滅
scoreboard players remove @s gadget_life 1
execute if score @s gadget_life matches ..0 at @s run particle minecraft:cloud ~ ~ ~ 0.4 0.3 0.4 0.05 15 force
execute if score @s gadget_life matches ..0 at @s run playsound minecraft:entity.wolf.death master @a ~ ~ ~ 1 1.2
execute if score @s gadget_life matches ..0 run kill @s
execute if score @s gadget_life matches ..0 run return 0

# 2. ターゲット選定 (自分以外のプレイヤー、半径15)
scoreboard players operation #WOLF_OWNER temp = @s player_id
tag @a remove wolf_target_candidate
execute at @s as @a[gamemode=!spectator,distance=..15] unless score @s player_id = #WOLF_OWNER temp run tag @s add wolf_target_candidate
# 最寄り
tag @a remove wolf_my_target
execute at @s as @a[tag=wolf_target_candidate,sort=nearest,limit=1] run tag @s add wolf_my_target

# ターゲット無し → 軽く見回し演出のみ
execute unless entity @a[tag=wolf_my_target] at @s run particle minecraft:dust{color:[0.5,0.5,0.5],scale:0.4} ~ ~1 ~ 0.2 0.2 0.2 0 1 force

# ターゲット有り → 接近 + 攻撃
# 3. 向きを合わせる (水平方向のみ、pitchは0で歩行)
execute if entity @a[tag=wolf_my_target] at @s run tp @s ~ ~ ~ facing entity @a[tag=wolf_my_target,limit=1] feet
execute if entity @a[tag=wolf_my_target] at @s run tp @s ~ ~ ~ ~ 0
# 4. 前進 (0.25m/tick = 約5m/s)
execute if entity @a[tag=wolf_my_target] at @s run tp @s ^ ^ ^0.25 ~ ~

# 4. 攻撃 (毎20tick = 1秒ごと、距離1.8以内)
scoreboard players add @s wolf_attack_timer 1
execute if score @s wolf_attack_timer matches 20.. at @s if entity @a[tag=wolf_my_target,distance=..1.8] as @a[tag=wolf_my_target,distance=..1.8,limit=1] run damage @s 2 minecraft:magic
execute if score @s wolf_attack_timer matches 20.. at @s if entity @a[tag=wolf_my_target,distance=..1.8] run playsound minecraft:entity.wolf.hurt master @a ~ ~ ~ 1 1.3
execute if score @s wolf_attack_timer matches 20.. at @s if entity @a[tag=wolf_my_target,distance=..1.8] run particle minecraft:crit ~ ~1 ~ 0.3 0.3 0.3 0.2 8 force
execute if score @s wolf_attack_timer matches 20.. run scoreboard players set @s wolf_attack_timer 0

# 5. 軽い視覚演出 (常時)
execute at @s run particle minecraft:dust{color:[0.5,0.5,0.5],scale:0.5} ~ ~0.5 ~ 0.1 0.1 0.1 0 1 force

# 後始末
tag @a remove wolf_target_candidate
tag @a remove wolf_my_target
