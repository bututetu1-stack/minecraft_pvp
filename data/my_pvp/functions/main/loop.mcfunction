# 1. 試合進行（game_logicを呼び出す）
execute if score #GLOBAL match_state matches 1 run function my_pvp:main/game_logic

# --- 死体処理タグのクリーンアップ ---
# バニラの死亡（deaths が増えた）を検出して `dead_processing` を付与
execute as @a if score @s deaths > @s last_death run tag @s add dead_processing
execute as @a if score @s deaths > @s last_death run scoreboard players operation @s last_death = @s deaths
# 生きている(HP>0)プレイヤーからは処理済みタグを外す
execute as @a[tag=dead_processing] store result score #HP temp run data get entity @s Health
# プレイヤーが復活（HP >=1）したら散布処理を行う
execute as @a[tag=dead_processing] if score #HP temp matches 1.. run function my_pvp:system/on_respawn

# ボーダー設定用トリガー検出（プレイヤーが `/trigger border_distance set <n>` または `/trigger border_remove set 1` を使う）
function my_pvp:system/check_border
