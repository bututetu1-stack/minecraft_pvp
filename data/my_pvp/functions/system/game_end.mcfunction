# 1. 試合状態を停止
scoreboard players set #GLOBAL match_state 2

# 2. タイトル表示
title @a title {"text":"GAME SET!","color":"red","bold":true}
title @a subtitle {"text":"お疲れ様でした！","color":"yellow"}

# 3. 効果音
playsound minecraft:ui.toast.challenge_complete master @a ~ ~ ~ 1 1

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

# 全員に対して個別に実行することでエラーを回避
execute as @a run attribute @s minecraft:generic.attack_damage base set 1

# これで「結果が表示されたまま、平和なロビー状態」になります。
# 次回 game_start 時に reset_game が呼ばれ、幽霊データも含めて全て綺麗に消えます。