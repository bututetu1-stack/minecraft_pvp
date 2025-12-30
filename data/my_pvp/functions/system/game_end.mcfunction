# 1. 試合状態を停止
scoreboard players set #GLOBAL match_state 2

# 2. タイトル表示
title @a title {"text":"GAME SET!","color":"red","bold":true}
title @a subtitle {"text":"お疲れ様でした！","color":"yellow"}

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
execute as @a if score @s points = #MAX_SCORE temp run tellraw @a [{"text":"🏆 WINNER: ","color":"gold"},{"selector":"@s","color":"yellow","bold":true},{"text":" (","color":"white"},{"score":{"name":"@s","objective":"points"},"color":"aqua"},{"text":" pts)","color":"white"}]

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
execute as @a run attribute @s minecraft:generic.attack_damage base set 1