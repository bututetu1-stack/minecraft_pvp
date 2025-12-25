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

# 【修正】攻撃力を標準(1.0)に戻す
# attributeコマンドは複数対象にとれないため、execute as @a run ... の形にします
execute as @a run attribute @s minecraft:generic.attack_damage base set 1

# 設置されたガジェット・くじ・カード等を全消去
kill @e[tag=gadget]
kill @e[tag=gadget_hitbox]
kill @e[tag=role_card]
kill @e[tag=ninja_shadow]
kill @e[tag=shadow_hitbox]

# 残留アイテムを一掃
kill @e[type=item,nbt={Item:{id:"minecraft:black_dye"}}]
kill @e[type=item,nbt={Item:{id:"minecraft:charcoal"}}]
kill @e[type=item,nbt={Item:{id:"minecraft:piston"}}]
kill @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}]
kill @e[type=item,nbt={Item:{id:"minecraft:iron_axe"}}]

# タイマーリセット
scoreboard players set #GLOBAL match_timer 0
scoreboard players set #GLOBAL match_state 0