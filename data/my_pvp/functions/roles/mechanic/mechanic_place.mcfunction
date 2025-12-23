# タレット設置 (トーチ) - スクラップ5消費
execute as @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}] at @s as @p[tag=mechanic,distance=..2,scores={scrap=5..}] run function my_pvp:roles/mechanic/spawn_sentry

# アイテムを消す
kill @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}]

# --- タレット (トーチ) ---
# 検知・実行
execute as @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}] at @s as @p[tag=mechanic,distance=..2,scores={scrap=5..}] run function my_pvp:roles/mechanic/spawn_sentry
# 補充：投げたプレイヤーに同じアイテムを戻す
execute as @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}] at @s run give @p minecraft:redstone_torch{display:{Name:'{"text":"マイクロタレット","italic":false,"color":"gold"}'}} 1
# 落ちているアイテムを消す
kill @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}]

# --- 地雷 (トラップドア) ---
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"}}] at @s as @p[tag=mechanic,distance=..2,scores={scrap=2..}] run function my_pvp:roles/mechanic/spawn_mine
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"}}] at @s run give @p minecraft:iron_trapdoor{display:{Name:'{"text":"地雷","italic":false,"color":"gray"}'}} 1
kill @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"}}]

# (ピストンとコンパスも同様に記述します)