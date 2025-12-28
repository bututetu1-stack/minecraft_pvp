# 1. 試合状態を停止
scoreboard players set #GLOBAL match_state 2

# 2. タイトル表示
title @a title {"text":"GAME SET!","color":"red","bold":true}
title @a subtitle {"text":"お疲れ様でした！","color":"yellow"}

# 3. 効果音
# 【修正】実行場所を各プレイヤーの位置(at @s)に変更
# これにより、原点から離れていても自分の場所で音が鳴るため確実に聞こえます
execute as @a at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1

# 4. 勝者発表（チャット欄）
# スコアが残っている状態で実行
tellraw @a [{"text":"-------------------","color":"gray"}]
tellraw @a [{"text":"🏆 WINNER: ","color":"gold"},{"selector":"@p[sort=arbitrary,limit=1,scores={points=-9999..}]"}]

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