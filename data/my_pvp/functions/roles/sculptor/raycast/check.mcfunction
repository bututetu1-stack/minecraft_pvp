# 判定処理
# 1. ブロック判定 (透過ブロックでなければ壁ヒット -> 終了)
execute unless block ~ ~ ~ #my_pvp:transparent run tellraw @a [{"text":"[DEBUG] Wall Hit at ","color":"gray"},{"text":"~ ~ ~"}]
execute unless block ~ ~ ~ #my_pvp:transparent run scoreboard players set #RAY_DIST temp 100
execute if score #RAY_DIST temp matches 100 run return 0

# 2. エンティティ判定 (Hitbox)
# ヒットしたら hit 関数を実行 (hit内でエフェクト付与 & ループ終了フラグセット)
# dx=0 を指定することで、現在の実行座標(レイの先端)がHitboxの範囲内に含まれているかを判定できる
execute as @e[type=interaction,tag=sculpture_hitbox,dx=0,limit=1,sort=nearest] run function my_pvp:roles/sculptor/raycast/hit

# ヒットして終了フラグが立っていたら戻る
execute if score #RAY_DIST temp matches 100 run return 0

# 3. 次のステップへ (再帰)
function my_pvp:roles/sculptor/raycast/loop
