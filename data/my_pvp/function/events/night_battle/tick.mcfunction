# 夜戦イベント継続処理
scoreboard players remove #GLOBAL event_duration 1

# 5tickごとにランダム砲撃
execute if score #GLOBAL event_duration matches 1.. run scoreboard players add #NIGHT_ATTACK temp 1
execute if score #NIGHT_ATTACK temp matches 10.. run function my_pvp:events/night_battle/random_attack
execute if score #NIGHT_ATTACK temp matches 10.. run scoreboard players set #NIGHT_ATTACK temp 0
