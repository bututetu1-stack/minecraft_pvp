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

# 設置されたガジェット・くじ・カード等を全消去
kill @e[tag=gadget]
kill @e[tag=gadget_hitbox]
kill @e[tag=role_card]

# 【追加】忍者の身代わりを全消去
kill @e[tag=ninja_shadow]

# 【追加】残留アイテムを一掃（重要：これで謎の身代わり発生を防ぎます）
kill @e[type=item,nbt={Item:{id:"minecraft:black_dye"}}]
kill @e[type=item,nbt={Item:{id:"minecraft:charcoal"}}]

# タイマーリセット
scoreboard players set #GLOBAL match_timer 0
scoreboard players set #GLOBAL match_state 0