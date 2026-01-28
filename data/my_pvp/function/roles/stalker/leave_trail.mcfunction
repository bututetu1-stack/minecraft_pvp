# ターゲットの足跡を残す
# @s = Target Player

# 5tickに1回設置 (頻度調整用スコアを作っても良いが、簡易的にタイマー共有or毎tick設置で寿命短くするなど)
# ここでは簡易タイマーを使用
scoreboard players add @s trail_timer 1
execute if score @s trail_timer matches 4.. run summon marker ~ ~ ~ {Tags:["stalker_trail"]}
execute if score @s trail_timer matches 4.. run scoreboard players set @s trail_timer 0

# マーカーにIDを継承 (直近に湧いたマーカーを取得)
scoreboard players operation #TEMP player_id = @s player_id
execute at @s as @e[type=marker,tag=stalker_trail,distance=..0.1,limit=1,sort=nearest] run scoreboard players operation @s target_id = #TEMP player_id

# 寿命設定 (例えば 200 tick = 10秒)
execute at @s as @e[type=marker,tag=stalker_trail,distance=..0.1,limit=1,sort=nearest] run scoreboard players set @s gadget_life 200
