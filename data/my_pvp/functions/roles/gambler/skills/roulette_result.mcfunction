# ルーレット結果処理
# @s = marker

# 乱数 (1-100)
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #RND temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
kill @e[tag=random_seed]
scoreboard players set #100 temp 100
scoreboard players operation #RND temp %= #100 temp
execute if score #RND temp matches ..0 run scoreboard players add #RND temp 100
execute if score #RND temp matches 0 run scoreboard players set #RND temp 100

# 範囲取得
# 金: (10%): 1-10
# 赤黒 (60%): 11-70
# 外れ (30%): 71-100

# 金 (Regen II, Absorption IV)
execute if score #RND temp matches 1..10 run particle minecraft:totem_of_undying ~ ~1 ~ 1 1 1 0.5 50
execute if score #RND temp matches 1..10 as @a[distance=..10] run tellraw @s {"text":"[Roulette] JACKPOT! (金)","color":"gold","bold":true}
execute if score #RND temp matches 1..10 as @a[distance=..10] run effect give @s minecraft:regeneration 20 1 true
execute if score #RND temp matches 1..10 as @a[distance=..10] run effect give @s minecraft:absorption 20 3 true
execute if score #RND temp matches 1..10 as @a[distance=..10] run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1

# 赤黒 (Slowness II, Wither II)
execute if score #RND temp matches 11..70 run particle minecraft:smoke ~ ~1 ~ 1 1 1 0.1 50
execute if score #RND temp matches 11..70 as @a[distance=..10] run tellraw @s {"text":"[Roulette] BAD LUCK... (赤黒)","color":"red","bold":true}
execute if score #RND temp matches 11..70 as @a[distance=..10] run effect give @s minecraft:slowness 10 1 true
execute if score #RND temp matches 11..70 as @a[distance=..10] run effect give @s minecraft:wither 10 1 true
execute if score #RND temp matches 11..70 as @a[distance=..10] run playsound minecraft:entity.wither.shoot master @s ~ ~ ~ 1 1

# 外れ
execute if score #RND temp matches 71..100 run particle minecraft:angry_villager ~ ~1 ~ 0.5 0.5 0.5 0 5
execute if score #RND temp matches 71..100 as @a[distance=..10] run tellraw @s {"text":"[Roulette] MISS (はずれ)","color":"gray"}
execute if score #RND temp matches 71..100 as @a[distance=..10] run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5

# 削除
kill @s
