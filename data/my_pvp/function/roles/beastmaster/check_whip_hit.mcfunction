# 鞭命中時 slowness 付与
# damage_dealt が増えた直後に呼ばれる (@s = beastmaster)

# 1. 攻撃対象候補 (4m以内、自分以外)
tag @a remove whip_victim
scoreboard players operation #BEAST_OWNER temp = @s player_id
execute at @s as @a[distance=0.1..4,sort=nearest,limit=1,gamemode=!spectator] unless score @s player_id = #BEAST_OWNER temp run tag @s add whip_victim

# 2. slowness I 1秒付与
execute as @a[tag=whip_victim] run effect give @s minecraft:slowness 1 0 true

# 3. 鞭しなり演出
execute if entity @a[tag=whip_victim] at @s run playsound minecraft:entity.player.attack.sweep master @a ~ ~ ~ 1 0.6
execute as @a[tag=whip_victim] at @s run particle minecraft:dust{color:[0.6,0.6,0.6],scale:0.8} ~ ~1 ~ 0.3 0.3 0.3 0 10 force

tag @a remove whip_victim
