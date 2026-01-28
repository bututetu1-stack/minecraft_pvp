# @s = Player
# デバッグ初期化
scoreboard players set #PLAYER_ROT temp -999

# 距離判定 (75m以内のみ)
execute if entity @s[distance=75.1..] run tellraw @s {"text":"[Roulette] 範囲外のため効果なし","color":"gray"}
execute if entity @s[distance=75.1..] run return 0

# 角度計算
# マーカーを自分の方に向ける
tag @s add current_calc_target
execute as @e[tag=angle_measure,limit=1] at @s anchored eyes facing entity @a[tag=current_calc_target,limit=1] feet run teleport @s ~ ~ ~ ~ ~
tag @s remove current_calc_target

# マーカーのYawを取得 (プレイヤーの方角)
execute store result score #PLAYER_ROT temp run data get entity @e[tag=angle_measure,limit=1] Rotation[0]

# デバッグ: 取得失敗時
execute if score #PLAYER_ROT temp matches -999 run tellraw @a {"text":"[Roulette Debug] Failed to get rotation!","color":"red"}
execute if score #PLAYER_ROT temp matches -999 run return 0

# 相対角度 = PlayerRot - RouletteRot
scoreboard players operation #PLAYER_ROT temp -= #ROULETTE_ROT temp

# 正規化 (0-360)
scoreboard players set #CONST_360 temp 360
scoreboard players operation #PLAYER_ROT temp %= #CONST_360 temp
execute if score #PLAYER_ROT temp matches ..-1 run scoreboard players add #PLAYER_ROT temp 360

# セクターID = Angle / 30
scoreboard players set #CONST_30 temp 30
scoreboard players operation #PLAYER_ROT temp /= #CONST_30 temp

# 効果適用 (0-11)
# 0: Red (Damage)
execute if score #PLAYER_ROT temp matches 0 run damage @s 10.0 minecraft:magic
execute if score #PLAYER_ROT temp matches 0 run tellraw @s {"text":"[Roulette] 赤: ダメージ！","color":"red"}

# 1: Blue (Heal)
execute if score #PLAYER_ROT temp matches 1 run effect give @s minecraft:instant_health 1 0
execute if score #PLAYER_ROT temp matches 1 run tellraw @s {"text":"[Roulette] 青: 回復！","color":"blue"}

# 2: Gold (Bonus)
execute if score #PLAYER_ROT temp matches 2 run scoreboard players add @s coins 50
execute if score #PLAYER_ROT temp matches 2 run scoreboard players add @s scrap 30
execute if score #PLAYER_ROT temp matches 2 run scoreboard players add @s mana 30
execute if score #PLAYER_ROT temp matches 2 run tellraw @s {"text":"[Roulette] 金: ボーナス！","color":"gold"}

# 3: Green (Speed)
execute if score #PLAYER_ROT temp matches 3 run effect give @s minecraft:speed 20 1 true
execute if score #PLAYER_ROT temp matches 3 run tellraw @s {"text":"[Roulette] 緑: 加速！","color":"green"}

# 4: Gray (Slowness)
execute if score #PLAYER_ROT temp matches 4 run effect give @s minecraft:slowness 20 1 true
execute if score #PLAYER_ROT temp matches 4 run tellraw @s {"text":"[Roulette] 灰: 鈍足...","color":"gray"}

# 5: Purple (Heavy Damage)
execute if score #PLAYER_ROT temp matches 5 run damage @s 20.0 minecraft:magic
execute if score #PLAYER_ROT temp matches 5 run tellraw @s {"text":"[Roulette] 紫: 大ダメージ！","color":"dark_purple"}

# 6: Aqua (Full Heal)
execute if score #PLAYER_ROT temp matches 6 run effect give @s minecraft:instant_health 1 10
execute if score #PLAYER_ROT temp matches 6 run tellraw @s {"text":"[Roulette] 水色: 全回復！","color":"aqua"}

# 7: White (Jackpot)
execute if score #PLAYER_ROT temp matches 7 run scoreboard players add @s coins 200
execute if score #PLAYER_ROT temp matches 7 run scoreboard players add @s scrap 100
execute if score #PLAYER_ROT temp matches 7 run scoreboard players add @s mana 100
execute if score #PLAYER_ROT temp matches 7 run effect give @s minecraft:speed 20 1 true
execute if score #PLAYER_ROT temp matches 7 run effect give @s minecraft:strength 20 0 true
execute if score #PLAYER_ROT temp matches 7 run effect give @s minecraft:regeneration 20 2 true
execute if score #PLAYER_ROT temp matches 7 run tellraw @s {"text":"[Roulette] 白: JACKPOT！！","color":"white","bold":true}

# 8: Yellow (Levitation)
execute if score #PLAYER_ROT temp matches 8 run effect give @s minecraft:levitation 10 1 true
execute if score #PLAYER_ROT temp matches 8 run tellraw @s {"text":"[Roulette] 黄: 浮遊！","color":"yellow"}

# 9: Black (Blindness)
execute if score #PLAYER_ROT temp matches 9 run effect give @s minecraft:blindness 20 0 true
execute if score #PLAYER_ROT temp matches 9 run tellraw @s {"text":"[Roulette] 黒: 暗闇...","color":"black"}

# 10: Dark Red (Strength)
execute if score #PLAYER_ROT temp matches 10 run effect give @s minecraft:strength 20 0 true
execute if score #PLAYER_ROT temp matches 10 run tellraw @s {"text":"[Roulette] 深紅: 筋力上昇！","color":"dark_red"}

# 11: Dark Gray (Weakness)
execute if score #PLAYER_ROT temp matches 11 run effect give @s minecraft:weakness 20 0 true
execute if score #PLAYER_ROT temp matches 11 run tellraw @s {"text":"[Roulette] 濃灰: 虚弱...","color":"dark_gray"}
