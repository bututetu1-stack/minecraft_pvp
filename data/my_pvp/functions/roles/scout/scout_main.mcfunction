# 1. UI表示
# 警告はチャットに出すことにしたので、ここは単純な切り替えだけでOKです
# ワイヤー移動中
execute if entity @s[tag=is_grappling] run title @s actionbar [{"text":">> GRAPPLING <<","color":"aqua","bold":true}]

# 通常時 (Scout Status)
execute unless entity @s[tag=is_grappling] run title @s actionbar [{"text":"Maneuverer Status","color":"aqua"}]


# 2. クールダウン消化
scoreboard players remove @s[scores={cd_wire=1..}] cd_wire 1
# CT完了音 (ピロリン♪)
execute if score @s cd_wire matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2


# --- 3. 矢の発射検知 ---
# 自分の近くに生まれたばかりの矢があれば、自分のIDを付与して管理下に置く
scoreboard players operation #TEMP player_id = @s player_id

# 高速な矢も逃さないよう distance=..5 に設定
execute as @e[type=arrow,tag=!wire_arrow,distance=..5] if score @p[tag=scout,distance=..5] player_id = #TEMP player_id run function my_pvp:roles/scout/init_arrow


# --- 4. 矢の処理 (着弾検知) ---
# ※ at @s を忘れずに (矢の位置で実行)
execute as @e[type=arrow,tag=wire_arrow] at @s run function my_pvp:roles/scout/arrow_tick


# --- 5. ワイヤー移動処理 ---
execute if entity @s[tag=is_grappling] run function my_pvp:roles/scout/pull_logic