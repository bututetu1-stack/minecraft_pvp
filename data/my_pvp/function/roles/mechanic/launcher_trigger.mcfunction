# --- 発動判定 ---
scoreboard players operation #TEMP player_id = @s player_id

# ターゲット選定
# 距離を 1.3 に拡大 (埋まっているASから足元のプレイヤーまでの距離は約1.0あるため)
# 自分以外の誰か
execute as @a[distance=..1.3] unless score @s player_id = #TEMP player_id run tag @s add launcher_target
# 自分自身 (即座に発動)
execute as @a[distance=..1.3] if score @s player_id = #TEMP player_id run tag @s add launcher_target

# ターゲットがいなければ終了
execute unless entity @a[tag=launcher_target] run return 0


# --- 発動アクション ---
# プレイヤーの位置(at @s)を基準に飛ばす
execute as @a[tag=launcher_target] at @s run tp @s ~ ~1.2 ~

# 浮遊と加速
execute as @a[tag=launcher_target] run effect give @s minecraft:levitation 1 15 true
execute as @a[tag=launcher_target] run effect give @s minecraft:speed 2 20 true

# 音とエフェクト
playsound minecraft:block.piston.extend ambient @a ~ ~ ~ 1 1.2
particle minecraft:cloud ~ ~0.5 ~ 0.5 0.2 0.5 0.2 30

# タグ掃除
tag @a[tag=launcher_target] remove launcher_target

# ガジェット消去
kill @s