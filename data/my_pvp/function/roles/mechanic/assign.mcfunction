# 1. タグ付け
tag @s add mechanic
tag @s add role_assigned
scoreboard players set @s role_id 1

# 2. チャットで通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『機械工』","color":"gold","bold":true},{"text":" です！","color":"white"}]

# 3. 攻撃能力の無効化
# 基礎攻撃力を0にする (これだけで素手などの攻撃は無力化されます)
attribute @s minecraft:attack_damage base set 0

# 【削除】Weaknessをかけると地雷等のダメージコマンドまで0になるため削除
# effect give @s minecraft:weakness infinite 255 true

# 4. クールダウン初期化
scoreboard players set @s cd_turret 0
scoreboard players set @s cd_mine 0
scoreboard players set @s cd_launcher 0
scoreboard players set @s cd_snare 0
scoreboard players set @s cooldown 0
scoreboard players set @s cd_super_jump 0
scoreboard players set @s sneak_time 0

# 5. 効果音
execute at @s run playsound minecraft:block.anvil.use master @s ~ ~ ~ 1 1
