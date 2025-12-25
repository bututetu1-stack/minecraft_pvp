# 全員のスコアをリセット
scoreboard players reset @a kills
scoreboard players reset @a deaths
scoreboard players reset @a points
scoreboard players reset @a scrap
# クールダウン系リセット
scoreboard players reset @a cd_turret
scoreboard players reset @a cd_mine
scoreboard players reset @a cd_launcher
scoreboard players reset @a cd_snare
# 忍者用CTリセット
scoreboard players reset @a cd_ninja_mark
scoreboard players reset @a cd_ninja_swap
scoreboard players reset @a cd_ninja_smoke

# インベントリクリア
clear @a

# エフェクトクリア
effect clear @a

# 役職タグリセット
tag @a remove role_assigned
tag @a remove mechanic
tag @a remove ninja
tag @a remove target_candidate

# 攻撃力を標準(1.0)に戻す
execute as @a run attribute @s minecraft:generic.attack_damage base set 1

# --- 【重要】ドロップ防止処理 ---
# killする前に、ガジェットや身代わりの装備・アイテム情報を空っぽにします。
# これにより、破壊時にアイテムがばら撒かれるのを防ぎます。
execute as @e[tag=gadget_visual] run data merge entity @s {HandItems:[{},{}],ArmorItems:[{},{},{},{}]}
execute as @e[tag=ninja_shadow] run data merge entity @s {HandItems:[{},{}],ArmorItems:[{},{},{},{}]}
execute as @e[tag=launcher] run data merge entity @s {ArmorItems:[{},{},{},{}]}

# 設置されたガジェット・くじ・カード等を全消去
kill @e[tag=gadget]
kill @e[tag=gadget_hitbox]
kill @e[tag=role_card]
kill @e[tag=ninja_shadow]
kill @e[tag=shadow_hitbox]

# --- 【修正】残留アイテムの完全消去 ---
# 指定して消すのではなく、この時点で落ちている全てのアイテムを消去します。
# 試合開始前なので、誤って必要なアイテムを消す心配はありません。
kill @e[type=item]

# タイマーリセット
scoreboard players set #GLOBAL match_timer 0
scoreboard players set #GLOBAL match_state 0