# 夜戦ランダム攻撃
# ランダムなプレイヤーの近くに攻撃を発生させる

# ランダムにターゲットを選択
tag @a remove night_target
tag @a[sort=random,limit=1] add night_target

# 攻撃タイプをランダム決定 (1=砲撃, 2=航空支援, 3=魚雷)
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #ATTACK_TYPE temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
scoreboard players set #CONST_3 temp 3
scoreboard players operation #ATTACK_TYPE temp %= #CONST_3 temp
scoreboard players add #ATTACK_TYPE temp 1
kill @e[tag=random_seed]

# --- 1. 砲撃 (Artillery) ---
execute if score #ATTACK_TYPE temp matches 1 at @a[tag=night_target] run function my_pvp:events/night_battle/spawn_artillery

# --- 2. 航空支援 (Air Strike) ---
execute if score #ATTACK_TYPE temp matches 2 at @a[tag=night_target] run function my_pvp:events/night_battle/spawn_airstrike

# --- 3. 魚雷 (Torpedo) ---
execute if score #ATTACK_TYPE temp matches 3 at @a[tag=night_target] run function my_pvp:events/night_battle/spawn_torpedo

tag @a remove night_target
