# --- 機械工（エンジニア）の処理 ---
# プレイヤー本人のスクラップ増加やUI表示（ここは変更なし）
execute as @a[tag=mechanic] run function my_pvp:roles/mechanic/mechanic_main

# --- 【追加】アイテム設置検知 ---
# プレイヤーごとのループから外し、ここで1回だけ実行します
function my_pvp:roles/mechanic/scan_items

# --- ガジェットの処理 ---
execute as @e[tag=gadget] at @s run function my_pvp:roles/mechanic/gadget_tic