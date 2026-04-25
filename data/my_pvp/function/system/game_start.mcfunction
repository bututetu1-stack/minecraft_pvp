# 1. 試合リセット処理
function my_pvp:system/reset_game

# --- 定数再設定 ---
scoreboard players set #POINT_KILL temp 10
scoreboard players set #POINT_DEATH temp 5
scoreboard players set #100 temp 100
scoreboard players set #20 temp 20

# --- ワールドボーダーと中心点の設定 ---
# 実行場所を中心とする
worldborder center ~ ~
# 半径150ブロック(直径300)に変更
worldborder set 120

# 古いマーカーがあれば削除し、新しい中心点マーカーを設置
kill @e[tag=game_center]
summon marker ~ ~ ~ {Tags:["game_center"]}

# プレイヤーを半径150以内... は start_sequence で行うため削除
# spreadplayers ~ ~ 30 150 false @a

# --- スコア初期化 ---
scoreboard players set @a kills 0
scoreboard players set @a deaths 0
scoreboard players set @a total_deaths 0
scoreboard players set @a points 0

# 2. IDリセット
scoreboard players set #NEXT_ID player_id 1
scoreboard players reset @a player_id
execute as @a run function my_pvp:system/assign_new_id

# 3. 役職抽選
function my_pvp:system/init_role_deck

# 【一時デバッグ】 init_role_deck 実行後の role_card 数を出力
execute store result score #DEBUG_CARDS temp if entity @e[tag=role_card]
tellraw @a [{"text":"[Debug] role_card count: ","color":"yellow"},{"score":{"name":"#DEBUG_CARDS","objective":"temp"},"color":"aqua"}]

# 【一時デバッグ】 役職未割当プレイヤー数を出力
execute store result score #DEBUG_PLAYERS temp if entity @a[tag=!role_assigned]
tellraw @a [{"text":"[Debug] unassigned players: ","color":"yellow"},{"score":{"name":"#DEBUG_PLAYERS","objective":"temp"},"color":"aqua"}]

function my_pvp:system/distribute_loop

# 【一時デバッグ】 distribute_loop 実行後の未割当プレイヤー数
execute store result score #DEBUG_PLAYERS temp if entity @a[tag=!role_assigned]
tellraw @a [{"text":"[Debug] after distribute, unassigned: ","color":"yellow"},{"score":{"name":"#DEBUG_PLAYERS","objective":"temp"},"color":"aqua"}]

# --- ボスバー初期化 ---
bossbar set my_pvp:timer players @a
bossbar set my_pvp:timer visible true
bossbar set my_pvp:timer color yellow
bossbar set my_pvp:timer value 6000

# 4. 開始合図
schedule function my_pvp:system/start_sequence 4s replace
