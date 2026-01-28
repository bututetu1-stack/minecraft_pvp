# 判定処理
say [DEBUG] raycast check running

# 1. ブロック判定 (透過ブロックでなければ壁ヒット -> 終了)
execute unless block ~ ~ ~ #my_pvp:transparent run say [DEBUG] Wall Hit
execute unless block ~ ~ ~ #my_pvp:transparent run scoreboard players set #RAY_DIST temp 100
execute if score #RAY_DIST temp matches 100 run return 0

# 2. エンティティ判定 (Hitbox)
execute as @e[type=interaction,tag=sculpture_hitbox,dx=0,limit=1,sort=nearest] run function my_pvp:roles/sculptor/raycast/hit

# ヒットして終了フラグが立っていたら戻る
execute if score #RAY_DIST temp matches 100 run return 0

# 3. 次のステップへ (再帰)
function my_pvp:roles/sculptor/raycast/loop
