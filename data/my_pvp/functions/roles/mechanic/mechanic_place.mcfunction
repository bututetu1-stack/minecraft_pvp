# --- 1. タレット (トーチ) : コスト 5 ---
# 補充：投げた瞬間にアイテムを戻す (killする前に実行)
execute as @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}] at @s run give @p[tag=mechanic,distance=..2] minecraft:redstone_torch{display:{Name:'{"text":"マイクロタレット","italic":false,"color":"gold"}'}} 1

# 成功判定 (5以上)
execute as @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}] at @s as @p[tag=mechanic,distance=..2,scores={scrap=5..}] run function my_pvp:roles/mechanic/spawn_sentry
# 失敗判定 (4以下：エラー音とメッセージ)
execute as @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}] at @s as @p[tag=mechanic,distance=..2,scores={scrap=..4}] run function my_pvp:roles/mechanic/scrap_error

# 削除
kill @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}]

# --- 2. 地雷 (鉄トラップドア) : コスト 2 ---
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"}}] at @s run give @p[tag=mechanic,distance=..2] minecraft:iron_trapdoor{display:{Name:'{"text":"地雷","italic":false,"color":"gray"}'}} 1

execute as @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"}}] at @s as @p[tag=mechanic,distance=..2,scores={scrap=2..}] run function my_pvp:roles/mechanic/spawn_mine
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"}}] at @s as @p[tag=mechanic,distance=..2,scores={scrap=..1}] run function my_pvp:roles/mechanic/scrap_error

kill @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"}}]

# --- 3. ランチャー (ピストン) : コスト 3 ---
execute as @e[type=item,nbt={Item:{id:"minecraft:piston"}}] at @s run give @p[tag=mechanic,distance=..4] minecraft:piston{display:{Name:'{"text":"インパクト・ランチャー","italic":false,"color":"gray"}'}} 1

execute as @e[type=item,nbt={Item:{id:"minecraft:piston"}}] at @s as @p[tag=mechanic,distance=..2,scores={scrap=3..}] run function my_pvp:roles/mechanic/spawn_launcher
execute as @e[type=item,nbt={Item:{id:"minecraft:piston"}}] at @s as @p[tag=mechanic,distance=..2,scores={scrap=..2}] run function my_pvp:roles/mechanic/scrap_error

kill @e[type=item,nbt={Item:{id:"minecraft:piston"}}]