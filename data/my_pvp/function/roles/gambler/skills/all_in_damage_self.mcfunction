# All-In Damage Macro (Self)
# Arguments: $(amount) - Damage calculation from storage

# 1. 一時的に借金状態にする (死んだら破産死扱いになる)
tag @s add all_in_suicide
scoreboard players set @s coins -1

# 2. ダメージ実行
tellraw @s {"text":"[DEBUG] Self Macro Amount: $(amount)"}
$damage @s $(amount) minecraft:magic

# 3. 生き残った場合は0に戻し、自滅フラグも外す (残すと次の無関係な死亡でペナルティが付く)
scoreboard players set @s coins 0
execute store result score #HP temp run data get entity @s Health 100
execute if score #HP temp matches 1.. run tag @s remove all_in_suicide
