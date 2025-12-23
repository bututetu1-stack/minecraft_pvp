# --- 機械工（エンジニア）の処理 ---
# プレイヤー本人のスクラップ増加やUI表示
execute as @a[tag=mechanic] run function my_pvp:roles/mechanic/mechanic_main

# --- ガジェットの処理 ---
# 【重要】at @s を付けることで、各ガジェットの「現在地」を基準に索敵できるようにします
execute as @e[tag=gadget] at @s run function my_pvp:roles/mechanic/gadget_tic