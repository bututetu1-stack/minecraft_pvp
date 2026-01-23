# コインチェック
execute if score @s coins matches ..14 run tellraw @s {"text":"[System] 戦争(War)に必要なコインが足りません (必要: 15)","color":"red"}
execute if score @s coins matches ..14 run return 0

# コイン消費
scoreboard players remove @s coins 15
tellraw @s {"text":"[War] 戦争を発動しました! (-15 Coins)","color":"red","bold":true}

# ★アイテム返却は不要 (攻撃発動なのでアイテムは消費されない)

# 自分の乱数生成 (1-13)
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #MY_CARD temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
kill @e[tag=random_seed]
scoreboard players set #13 temp 13
scoreboard players operation #MY_CARD temp %= #13 temp
execute if score #MY_CARD temp matches ..0 run scoreboard players add #MY_CARD temp 13
execute if score #MY_CARD temp matches 0 run scoreboard players set #MY_CARD temp 13

# 相手の乱数生成 (1-13)
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #ENEMY_CARD temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
kill @e[tag=random_seed]
scoreboard players operation #ENEMY_CARD temp %= #13 temp
execute if score #ENEMY_CARD temp matches ..0 run scoreboard players add #ENEMY_CARD temp 13
execute if score #ENEMY_CARD temp matches 0 run scoreboard players set #ENEMY_CARD temp 13

# 結果表示
tellraw @s [{"text":"[War] あなた: ","color":"aqua"},{"score":{"name":"#MY_CARD","objective":"temp"}},{"text":" vs ","color":"gray"},{"text":"敵: ","color":"red"},{"score":{"name":"#ENEMY_CARD","objective":"temp"}}]

# ターゲット特定 (近い敵 = 殴られた敵)
# execute if score @s damage_dealt... から呼ばれているので、距離6以内の敵を探す
tag @s add current_attacker
execute as @a[distance=..6,tag=!current_attacker,limit=1,sort=nearest] run tag @s add current_target

# Win (My > Enemy)
execute if score #MY_CARD temp > #ENEMY_CARD temp run tellraw @a[tag=current_attacker] {"text":"[War] YOU WIN! (敵に盲目＆鈍足)","color":"gold"}
execute if score #MY_CARD temp > #ENEMY_CARD temp as @a[tag=current_target] run effect give @s minecraft:blindness 10 0 true
execute if score #MY_CARD temp > #ENEMY_CARD temp as @a[tag=current_target] run effect give @s minecraft:slowness 10 1 true

# Lose (My < Enemy)
execute if score #MY_CARD temp < #ENEMY_CARD temp run tellraw @a[tag=current_attacker] {"text":"[War] YOU LOSE... (自分に盲目＆鈍足)","color":"red"}
execute if score #MY_CARD temp < #ENEMY_CARD temp as @a[tag=current_attacker] run effect give @s minecraft:blindness 10 0 true
execute if score #MY_CARD temp < #ENEMY_CARD temp as @a[tag=current_attacker] run effect give @s minecraft:slowness 10 1 true

# Draw (My = Enemy)
execute if score #MY_CARD temp = #ENEMY_CARD temp run tellraw @a[tag=current_attacker] {"text":"[War] DRAW (コイン返還)","color":"gray"}
execute if score #MY_CARD temp = #ENEMY_CARD temp run scoreboard players add @a[tag=current_attacker] coins 15

# ダメージ2倍フラグ処理 (運命のコイン)
execute if score @s damage_boost matches 1 run effect give @a[tag=current_target] minecraft:instant_damage 1 0
execute if score @s damage_boost matches 1 run tellraw @s {"text":"[Fate] 追加ダメージを与えました","color":"aqua"}
execute if score @s damage_boost matches 1 run scoreboard players set @s damage_boost 0

# タグ削除
tag @a remove current_attacker
tag @a remove current_target
