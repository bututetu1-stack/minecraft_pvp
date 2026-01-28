# バウンティイベント開始

# 最高ポイント者を特定
scoreboard players set #MAX_POINTS temp -2147483648
execute as @a run scoreboard players operation #MAX_POINTS temp > @s points

# 最高ポイント者にタグ付与 (候補者)
tag @a remove bounty_candidate
execute as @a if score @s points = #MAX_POINTS temp run tag @s add bounty_candidate

# 候補者の中からランダムに1人をターゲットにする
tag @a remove bounty_target
tag @a[tag=bounty_candidate,sort=random,limit=1] add bounty_target
tag @a remove bounty_candidate

# 告知
title @a title [{"text":"【賞金首】","color":"red","bold":true}]
execute as @a[tag=bounty_target] run title @a subtitle [{"selector":"@s","color":"yellow"},{"text":" に懸賞金！","color":"white"}]
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"バウンティ","color":"red","bold":true},{"text":" - 賞金首を倒すと50ポイント！","color":"white"}]
execute as @a at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1.0 0.5 1.0
