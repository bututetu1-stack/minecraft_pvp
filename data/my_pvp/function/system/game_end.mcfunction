# 1. 試合状態を停止
scoreboard players set #GLOBAL match_state 2

# ボスバーを隠す
bossbar set my_pvp:timer visible false

# 2. タイトル表示
# 2. タイトル表示 (WINNERは後で判定してサブタイトルに表示)
title @a title {"text":"GAME SET!","color":"red","bold":true}
# title @a subtitle {"text":"お疲れ様でした！","color":"yellow"}

# 3. 効果音
# 実行場所を各プレイヤーの位置(at @s)に変更
execute as @a at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1

# --- 4. 勝者判定ロジック (修正版) ---
tellraw @a [{"text":"-------------------","color":"gray"}]

# (1) 最大スコア変数の初期化 (Int最小値など、あり得ない低い値にする)
scoreboard players set #MAX_SCORE temp -2147483648

# (2) 全プレイヤーのスコアを参照し、最大値を #MAX_SCORE にコピーする
#     operation > は「左辺が右辺より小さければ、右辺の値を代入する」という動作
execute as @a run scoreboard players operation #MAX_SCORE temp > @s points

# (3) 自分のスコアが最大値(#MAX_SCORE)と一致するプレイヤーを優勝者として表示
#     セレクター(@s)を使うことで、同点の場合も全員正しく表示されます
# (3) 勝者数をカウント
scoreboard players set #WINNER_COUNT temp 0
execute as @a if score @s points = #MAX_SCORE temp run scoreboard players add #WINNER_COUNT temp 1

# (4) 分岐表示
# A. 単独優勝 (WINNER: Name)
execute if score #WINNER_COUNT temp matches 1 as @a if score @s points = #MAX_SCORE temp run title @a subtitle [{"text":"🏆 WINNER: ","color":"gold"},{"selector":"@s","color":"yellow","bold":true},{"text":" (","color":"white"},{"score":{"name":"@s","objective":"points"},"color":"aqua"},{"text":" pts)","color":"white"}]

# B. 複数優勝 (DRAW! -> Chatに一覧表示)
execute if score #WINNER_COUNT temp matches 2.. run title @a subtitle {"text":"🏆 DRAW! (Multiple Winners)","color":"gold","bold":true}
execute if score #WINNER_COUNT temp matches 2.. run tellraw @a {"text":"=== 🏆 WINNERS 🏆 ===","color":"gold"}
execute if score #WINNER_COUNT temp matches 2.. as @a if score @s points = #MAX_SCORE temp run tellraw @a [{"text":"- ","color":"gray"},{"selector":"@s","color":"yellow"},{"text":" (","color":"white"},{"score":{"name":"@s","objective":"points"},"color":"aqua"},{"text":" pts)","color":"white"}]

# (4) 優勝者に演出
execute as @a if score @s points = #MAX_SCORE temp run playsound minecraft:entity.player.levelup master @a ~ ~ ~ 1 0.5


# --- 5. 盤面のお片付け (スコアは残す) ---
# ※ reset_game は呼ばず、邪魔なエンティティだけ消します。
# 完全にリセットされるのは、次の game_start が実行された瞬間です。

# ガジェット・設置物・アイテムの消去
kill @e[tag=gadget]
kill @e[tag=gadget_visual]
kill @e[tag=gadget_hitbox]
kill @e[tag=turret_shot]

# 忍者の設置物
kill @e[tag=ninja_shadow]
kill @e[tag=shadow_hitbox]
kill @e[tag=ninja_proj]

# 彫刻家の設置物
kill @e[tag=sculpture]
kill @e[tag=sculpture_hitbox]

# 提督の航空支援
kill @e[tag=airstrike_center]
kill @e[tag=adm_plane]
kill @e[type=phantom]

# 獣使いの召喚獣 (wolf)
kill @e[tag=beast_wolf]

# 魔術師の業火マーカー
kill @e[tag=mag_inferno]
kill @e[tag=mag_fireball]

# その他システム用マーカー
kill @e[tag=role_card]

# ドロップアイテム
kill @e[type=item]

# プレイヤーの武装解除 (PVP停止)
clear @a
effect clear @a

# 体力と満腹度を全回復
effect give @a minecraft:instant_health 1 100 true
effect give @a minecraft:saturation 1 255 true

# 全員に対して個別に実行することでエラーを回避
execute as @a run attribute @s minecraft:attack_damage base set 1

# --- 6. 全員を中心（コマンドブロックの位置）に集合させる ---
# game_center は game_start 時に設置されたマーカーです
tp @a @e[tag=game_center,limit=1]

# 向きを揃えたい場合（オプション: 南向きなど）
# execute as @a at @s run tp @s ~ ~ ~ 0 0