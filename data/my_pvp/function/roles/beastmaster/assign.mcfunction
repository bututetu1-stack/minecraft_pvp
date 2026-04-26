# 1. タグ付け
tag @s add beastmaster
scoreboard players set @s role_id 14
tag @s add role_assigned

# 2. 通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『獣使い』","color":"gray","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定
function my_pvp:roles/beastmaster/apply_status

# 4. クールダウン初期化
scoreboard players set @s cd_beast_wolf 0
scoreboard players set @s cd_beast_roar 0
scoreboard players set @s cd_beast_unleash 0
scoreboard players set @s cd_super_jump 0
scoreboard players set @s sneak_time 0
scoreboard players set @s wolf_count 0

# 5. 攻撃力 (鞭で攻撃するため基礎は 1)
attribute @s minecraft:attack_damage base set 1

# 6. 音
execute at @s run playsound minecraft:entity.wolf.howl master @s ~ ~ ~ 1 1
execute at @s run playsound minecraft:entity.wolf.ambient master @s ~ ~ ~ 0.7 1.5
